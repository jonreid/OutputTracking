import Foundation
import NetworkRequestLibrary

@main
struct NetworkRequestApp {
    static func main() async {
        print("Network Request Example")
        print("======================")
        
        let service = NetworkService()
        let output = await service.trackOutput()
        
        let urls = [
            "https://api.example.com/users",
            "https://api.example.com/posts",
            "https://api.example.com/comments"
        ]
        
        for url in urls {
            await service.fetchData(from: url)
        }
        
        // Show tracked output
        if let trackedUrls = output.data as? [String] {
            print("\nTracked URLs:")
            for (index, url) in trackedUrls.enumerated() {
                print("\(index + 1). \(url)")
            }
        }
        
        print("\nDone!")
    }
}
