@testable import NetworkRequestLibrary
import Testing

@Test("Search passes correct URL")
func searchForBook_URL() async throws {
    let sut = NetworkService.createNull()
    let output = await sut.trackOutput()

    let _ = try await sut.searchForBook(terms: "two words")

    let urls = try #require(output.data as? [String])
    #expect(urls == ["https://itunes.apple.com/search?media=ebook&term=two%20words"])
}
