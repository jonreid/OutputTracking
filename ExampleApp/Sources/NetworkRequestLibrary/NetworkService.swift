import Foundation
import OutputTracking

public class NetworkService {
    private let outputRegistry = OutputRegistry()
    
    public init() {}
    
    public func fetchData(from url: String) async {
        await outputRegistry.track(url)
        print("Fetching data from: \(url)")
        // Simulate network work
        print("Fetch completed")
    }
    
    public func trackOutput() async -> OutputLog {
        await outputRegistry.registeredLog()
    }
}
