// OutputTracking by Jon Reid, https://qualitycoding.org
// Copyright 2026 Jonathan M. Reid. https://github.com/jonreid/OutputTracking/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

public final class OutputLog: @unchecked Sendable {
    private(set) weak var outputRegistry: OutputRegistry?
    private var output: [Any] = []

    public init(outputRegistry: OutputRegistry) {
        self.outputRegistry = outputRegistry
    }
    
    public func add(_ data: Any) {
        output.append(data)
    }
    
    public var data: [Any] {
        output
    }
    
    public func clear() {
        output.removeAll()
    }
    
    public func stop() async {
        await outputRegistry?.remove(self)
    }
}
