/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
import XCTest
@testable import Adian

class FoundationTaskTests: XCTestCase {
    let task = FoundationTask()
    let defaultTimeout = 0.1 /* seconds */


    func testDeliversProcessSuccessAfterCallingTrue() {
        task.command = ["/usr/bin/true"]
        runTaskAndCheckOnCompletion { (output, ok) -> Void in
            XCTAssertTrue(ok, "true should always exit successfully")
        }
    }


    func testDeliversProcessFailureAfterCallingFalse() {
        task.command = ["/usr/bin/false"]
        runTaskAndCheckOnCompletion { (output, ok) -> Void in
            XCTAssertFalse(ok, "false should always exit unsuccessfully")
        }
    }


    /// Tests it's feeding arguments in appropriately.
    func testDeliversStandardOutputWhenInvokedWithEcho() {
        task.command = ["/bin/echo"]
        runTaskAndCheckOnCompletion { (output, ok) -> Void in

        }
    }


    /// Tests it's feeding stdin in appropriately.
    func xtestDeliversStandardOutputWhenInvokedWithCat() {
    }
}



extension FoundationTaskTests {
    func runTaskAndCheckOnCompletion(checks: (output: String, ok: Bool) -> Void) {
        let expectingCompletion = expectationWithDescription("\(task) calls completion")
        task.run { [weak expectingCompletion] (output, ok) -> Void in
            expectingCompletion?.fulfill()

            checks(output: output, ok: ok)
        }
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
    }
}
