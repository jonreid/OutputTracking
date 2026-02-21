import XCTest
@testable import NetworkRequestLibrary

final class NetworkServiceTests: XCTestCase {
    
    func testNetworkServiceTracksURLs() async throws {
        // Arrange
        let service = NetworkService()
        let output = await service.trackOutput()
        let testURL = "https://api.example.com/test"
        
        // Act
        await service.fetchData(from: testURL)
        
        // Assert
        let trackedURLs = try XCTUnwrap(output.data as? [String])
        XCTAssertEqual(trackedURLs.count, 1)
        XCTAssertEqual(trackedURLs.first, testURL)
    }
    
    func testNetworkServiceTracksMultipleURLs() async throws {
        // Arrange
        let service = NetworkService()
        let output = await service.trackOutput()
        let testURLs = [
            "https://api.example.com/users",
            "https://api.example.com/posts"
        ]
        
        // Act
        for url in testURLs {
            await service.fetchData(from: url)
        }
        
        // Assert
        let trackedURLs = try XCTUnwrap(output.data as? [String])
        XCTAssertEqual(trackedURLs.count, 2)
        XCTAssertEqual(trackedURLs, testURLs)
    }
}
