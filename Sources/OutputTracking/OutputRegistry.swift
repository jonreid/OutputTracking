// OutputTracking by Jon Reid, https://qualitycoding.org
// Copyright 2026 Jonathan M. Reid. https://github.com/jonreid/OutputTracking/blob/main/LICENSE.txt
// SPDX-License-Identifier: MIT

actor OutputRegistry {
    private(set) var logs: [OutputLog] = []

    func track(_ data: Any) {
        logs.forEach { $0.add(data) }
    }
    func registeredLog() -> OutputLog {
        let log = OutputLog(outputRegistry: self)
        logs.append(log)
        return log
    }
    func remove(_ outputLog: OutputLog) {
        logs.removeAll { $0 === outputLog }
    }
}
