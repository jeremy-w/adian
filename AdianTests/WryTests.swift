/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
import XCTest
@testable import Adian

class SpyTask: Task {
    var command: [String] = []
    var input = ""
    var environment: [String: String] = [:]

    var completion = {(output: String, ok: Bool) -> Void in }

    func run(completion: (output: String, ok: Bool) -> Void) {
        /* pass */
    }
}



class WryTests: XCTestCase {
    let spyTask = SpyTask()
    var wry: Wry?


    override func setUp() {
        wry = Wry(task: spyTask)
    }


    func testPostMessageConfiguresTaskToSend() {
        wry!.postMessage(AnyMessage)
        XCTAssertEqual(spyTask.command, "wry post".componentsSeparatedByString(" "))
        XCTAssertEqual(spyTask.input, AnyMessage)
        XCTAssertTrue(spyTask.environment.contains { $0 == "WRY_EDITOR" && $1 == "STDIN" },
            "environment missing WRY_EDITOR=STDIN: \(spyTask.environment)")
    }
}
