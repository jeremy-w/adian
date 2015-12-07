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
        task.arguments = Array(command[1..<command.count])

        let pipe = NSPipe()
        task.standardOutput = pipe

        let stdout = pipe.fileHandleForReading
        let data = NSMutableData()
        NSLog("READING!")
        stdout.readabilityHandler = { (handle: NSFileHandle) in
            NSLog("CALLED!")
            let readData = handle.availableData
            NSLog("read \(readData.length) bytes")

            guard readData.length != 0 else {
                NSLog("read EOF")
                handle.readabilityHandler = nil
                return
            }

            data.appendData(readData)
        }

        task.terminationHandler = { task in
            NSLog("TERMINATED!")
            let ok = task.terminationStatus == 0
            let output = self.decodeUTF8(data)
            completion(output: output, ok: ok)
        }
        task.launch()
    }


    private func decodeUTF8(data: NSData) -> String {
        let output: String
        if let decodedString = String(data: data, encoding: NSUTF8StringEncoding) {
            output = decodedString
        } else {
            NSLog("\(self): failed to decode \(data.length) bytes of data written to stdout as UTF-8 text")
            output = ""
        }
        return output
    }
}

extension FoundationTask: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(self.dynamicType)(command \(command) - input \"(input)\" - environment \(environment))"
    }
}
