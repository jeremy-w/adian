/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
import Foundation

class FoundationTask: Task {
    var command: [String] = []
    var input = ""
    var environment: [String: String] = [:]

    func run(completion: (output: String, ok: Bool) -> Void) {
        let task = NSTask()
        task.launchPath = command.first
        task.arguments = command
        task.terminationHandler = { task in
            let ok = task.terminationStatus == 0
            completion(output: "", ok: ok)
        }
        task.launch()
    }
}

extension FoundationTask: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self.dynamicType)(command \(command) - input \"(input)\" - environment \(environment))"
    }
}
