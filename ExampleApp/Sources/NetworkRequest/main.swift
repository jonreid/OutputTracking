import Foundation
import NetworkRequestLibrary

@main
struct NetworkRequestApp {
    static func main() async {
        let searchTerm = "out from boneville"
        print("Searching for books with terms: \(searchTerm)")
        
        let service = NetworkService.create()
        do {
            let (data, response) = try await service.searchForBook(terms: searchTerm)
            let httpResponse = response as! HTTPURLResponse
            let jsonString = String(decoding: data, as: UTF8.self)
            print("HTTP Status: \(httpResponse.statusCode)")
            print("Response received: \(jsonString.prefix(1000))...")
        } catch {
            print("Search failed: \(error)")
        }
    }
}
