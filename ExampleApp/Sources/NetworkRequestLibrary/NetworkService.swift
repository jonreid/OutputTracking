import Foundation
import OutputTracking

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public class NetworkService {
    private let useRealSession: Bool
    private let outputRegistry = OutputRegistry()
    
    private init(useRealSession: Bool) {
        self.useRealSession = useRealSession
    }
    
    public static func create() -> NetworkService {
        return NetworkService(useRealSession: true)
    }
    
    public static func createNull() -> NetworkService {
        return NetworkService(useRealSession: false)
    }

    public func trackOutput() async -> OutputLog {
        await outputRegistry.registeredLog()
    }
    
    public func searchForBook(terms: String) async throws -> (Data, URLResponse) {
        guard let encodedTerms = terms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            throw SearchError.encodingFailed
        }
        
        let url = URL(string: "https://itunes.apple.com/search?media=ebook&term=\(encodedTerms)")!
        await outputRegistry.track(url.absoluteString)

        guard useRealSession else { return dummyResponse(for: url) }
        return try await URLSession.shared.data(from: url)
    }
    
    private func dummyResponse(for url: URL) -> (Data, URLResponse) {
        let dummyResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: [:])!
        let dummyJSON = """
        {
            "resultCount": 0,
            "results": []
        }
        """
        let dummyData = Data(dummyJSON.utf8)
        return (dummyData, dummyResponse)
    }
}

public enum SearchError: Error {
    case encodingFailed
}
