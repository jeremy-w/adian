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

    var monitor: ProcessMonitor?
    func run(completion: (output: String, ok: Bool) -> Void) {
        precondition(self.monitor == nil, "\(self) is a one-shot task runner, and \(__FUNCTION__) has already been called once!")
        let task = NSTask()
        task.launchPath = command.first
        task.arguments = Array(command[1..<command.count])

        let inPipe = NSPipe()
        task.standardInput = inPipe
        inPipe.fileHandleForWriting.closeFile()

        let outPipe = NSPipe()
        task.standardOutput = outPipe

        let stdout = outPipe.fileHandleForReading
        let monitor = ProcessMonitor(task: task, output: stdout, whenDone: { (output, task) -> Void in
            let string = self.decodeUTF8(output as! NSData)
            let ok = task.terminationStatus == 0
            completion(output: string, ok: ok)
        })
        monitor.begin()
        self.monitor = monitor

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



/// Aggregates process output and termination status.
class ProcessMonitor {
    let task: NSTask
    let output: NSFileHandle
    let whenDone: (output: dispatch_data_t, task: NSTask) -> Void

    /// Assumes ownership of `task.terminationHandler` and the file descriptor backing `output`.
    init(task: NSTask, output: NSFileHandle, whenDone: (output: dispatch_data_t, task: NSTask) -> Void) {
        self.task = task
        self.output = output
        self.whenDone = whenDone
    }


    /// Begins draining `output`.
    func begin() {
        registerTerminationHandler()
        drainFileHandle()
        asyncWaitTillDone()
    }


    private let group = dispatch_group_create()
    private var data = dispatch_data_empty


    private func registerTerminationHandler() {
        dispatch_group_enter(group)

        self.task.terminationHandler = { task in
            dispatch_group_leave(self.group)
        }
    }


    private func drainFileHandle() {
        dispatch_group_enter(group)

        let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        let channel = dispatch_io_create(DISPATCH_IO_STREAM, output.fileDescriptor, queue) { (did_error) -> Void in
            self.output.closeFile()
        }
        dispatch_io_read(channel, 0, Int.max, queue) { (done, chunk, error) -> Void in
            self.data = dispatch_data_create_concat(self.data, chunk)
            if done {
                dispatch_group_leave(self.group)
            }
        }
    }


    private func asyncWaitTillDone() {
        let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        dispatch_group_notify(group, queue) { _ in
            self.whenDone(output: self.data, task: self.task)
        }
    }
}
