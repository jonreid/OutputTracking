# OutputTracking

**Replace mocks with tracked output in your Swift tests.**

Spies (some call them “mocks”) are a way to write interaction tests. They answer, “Did the System Under Test call the right function in this dependency, passing the right arguments?”

This works. But it requires introducing a protocol (or closure), and testing against an implementation detail. This locks in the implementation, making refactoring difficult.

[James Shore’s “Nullables” pattern language](https://www.jamesshore.com/v2/projects/nullables) offers an alternative approach. You add “nullable” implementations directly into production code so tests can control behavior at architectural boundaries. This lets us write tests checking the behavior of connected components without using mocks or spies.

But we still need a way to capture data. [Output Tracking](https://www.jamesshore.com/v2/projects/nullables/testing-without-mocks#output-tracking) is a simple output system designed for testing.

## Why OutputTracking Instead of Mocks?

- **More realistic** — Tests verify actual behavior, not fake implementations
- **Less brittle** — Tests don't break when implementation details change
- **Easier maintenance** -—No complex mock setups or verification chains
- **Better coverage** — Tests exercise real code paths

## Quick Start

```swift
import OutputTracking
 
// Create a service that tracks its output
class NetworkService {
    private let outputRegistry = OutputRegistry()
    
    func fetchData(from url: String) async {
        await outputRegistry.track(url)
        // ... actual network logic
    }
    
    func trackOutput() async -> OutputLog {
        await outputRegistry.registeredLog()
    }
}
 
// In your tests
@Test("Network service fetches correct URL")
func test_fetchData_url() async throws {
    let sut = NetworkService()
    let output = await sut.trackOutput()
    
    await sut.fetchData(from: "https://api.example.com")
    
    let urls = try #require(output.data as? [String])
    #expect(urls == ["https://api.example.com"])
}
```

## Core Components

### OutputRegistry

An actor that manages multiple output logs and broadcasts data to all active logs.

### OutputLog

A collection that captures tracked data. Each log receives all data broadcast by its registry.

### Usage Pattern

1. Create an OutputRegistry in your type
2. Call `await outputRegistry.track(data)` when interesting events happen
3. Tests ask the type for an OutputLog
4. Verify the captured data in your tests

## Installation

Add to your Package.swift dependencies:

```swift
.package(url: "https://github.com/jonreid/OutputTracking.git", from: "1.0.0")
```

## About the Author

Jon Reid is the author of _[iOS Unit Testing by Example](https://iosunittestingbyexample.com)._  
Find more at [Quality Coding](https://qualitycoding.org).

[![Bluesky](https://img.shields.io/bluesky/followers/qualitycoding.org)](https://bsky.app/profile/qualitycoding.org)
[![Mastodon](https://img.shields.io/mastodon/follow/109765011064804734?domain=https%3A%2F%2Fiosdev.space
)](https://iosdev.space/@qcoding)
[![YouTube](https://img.shields.io/youtube/channel/subscribers/UC69XtVGLRydpG7o1nkdQs8Q)](https://www.youtube.com/@QualityCoding)
[![GitHub](https://img.shields.io/github/stars/jonreid)](https://github.com/jonreid)
