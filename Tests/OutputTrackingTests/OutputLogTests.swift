// OutputTracking by Jon Reid, https://qualitycoding.org
// Copyright 2026 Jonathan M. Reid. https://github.com/jonreid/OutputTracking/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

@testable import OutputTracking
import Testing

@Suite("Output Log Tests")
@MainActor
final class OutputLogTests: Sendable {
    private let outputRegistry = OutputRegistry()
    private let sut: OutputLog

    init() async {
        sut = await outputRegistry.registeredLog()
    }

    @Test("Add stores data")
    func addData() throws {
        sut.add("Test Data")

        let logData = try #require(sut.data as? [String])
        #expect(logData == ["FOO Test Data"])
    }

    @Test("Clear removes all data")
    func clear() {
        sut.add("Test Data 1")
        sut.add("Test Data 2")
        #expect(sut.data.count == 2, "Precondition")

        sut.clear()

        #expect(sut.data.count == 0)
    }

    @Test("Stop removes log from registry")
    func stop_removesLog() async {
        sut.add("Test Data")
        #expect(await outputRegistry.logs.count == 1, "Precondition")

        await sut.stop()

        #expect(await outputRegistry.logs.count == 0)
    }
}
