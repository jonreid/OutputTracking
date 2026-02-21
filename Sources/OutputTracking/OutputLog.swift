// OutputTracking by Jon Reid, https://qualitycoding.org
// Copyright 2026 Jonathan M. Reid. https://github.com/jonreid/OutputTracking/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

final class OutputLog: @unchecked Sendable {
    private(set) weak var outputRegistry: OutputRegistry?
    private var output: [Any] = []

    init(outputRegistry: OutputRegistry) {
        self.outputRegistry = outputRegistry
    }
    
    func add(_ data: Any) {
        output.append(data)
    }
    
    var data: [Any] {
        output
    }
    
    func clear() {
        output.removeAll()
    }
    
    func stop() async {
        await outputRegistry?.remove(self)
    }
}
