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

        let inPipe = NSPipe()
        task.standardInput = inPipe
        inPipe.fileHandleForWriting.closeFile()

        let outPipe = NSPipe()
        task.standardOutput = outPipe

        let group = dispatch_group_create()
        dispatch_group_enter(group)  // readability handler
        dispatch_group_enter(group)  // termination handler

        let stdout = outPipe.fileHandleForReading
        let data = NSMutableData()
        let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        let channel = dispatch_io_create(DISPATCH_IO_STREAM, stdout.fileDescriptor, queue) { (did_error) -> Void in
            stdout.closeFile()
        }
        dispatch_io_read(channel, 0, Int.max, queue) { (done, chunk, error) -> Void in
            let chunkData = chunk as! NSData
            NSLog("read \(chunkData.length) bytes")
            data.appendData(chunkData)
            if done {
                NSLog("hit EOF - error \(error)")
                dispatch_group_leave(group)
            }
        }

        task.terminationHandler = { task in
            stdout.closeFile()
            NSLog("TERMINATED!")
            let ok = task.terminationStatus == 0
            dispatch_group_notify(group, dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), { () -> Void in
                NSLog("group finished")
                let output = self.decodeUTF8(data)
                completion(output: output, ok: ok)
            })
            dispatch_group_leave(group)
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
