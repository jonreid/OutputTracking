// OutputTracking by Jon Reid, https://qualitycoding.org
// Copyright 2026 Jonathan M. Reid. https://github.com/jonreid/OutputTracking/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

@testable import OutputTracking
import Testing

@MainActor
@Suite("Output Registry Tests")
final class OutputRegistryTests: Sendable {
    private let sut = OutputRegistry()
    private let log1: OutputLog
    private let log2: OutputLog

    init() async {
        log1 = await sut.registeredLog()
        log2 = await sut.registeredLog()
    }

    @Test("Track data broadcasts to all logs")
    func trackData() async throws {
        await sut.track("Test Data")

        #expect(log1.data as? [String] == ["Test Data"])
        #expect(log2.data as? [String] == ["Test Data"])
    }

    @Test("Creating logs updates registry")
    func createLog() async {
        #expect(await sut.logs.count == 2)
        #expect(log1.outputRegistry === sut)
        #expect(log2.outputRegistry === sut)
    }

    @Test("Removing logs updates registry")
    func removeLog() async {
        await sut.remove(log1)

        #expect(await sut.logs.count == 1)
        #expect(await sut.logs.first === log2)
    }
}
