/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
import XCTest
@testable import Adian

class FoundationTaskTests: XCTestCase {
    let task = FoundationTask()
    let defaultTimeout = 0.5 /* seconds */


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
    func testDeliversStandardOutputWhenInvokedWithPrintf() {
        let input = "howdy!\n"
        task.command = ["/usr/bin/printf", input]
        runTaskAndCheckOnCompletion { (output, ok) -> Void in
            XCTAssertTrue(ok, "printf should have run fine")
            XCTAssertEqual(output, input)
        }
    }


    /// Tests it's feeding stdin in appropriately.
    func testDeliversStandardOutputWhenInvokedWithCat() {
        let input = "howdy!\n"
        task.input = input
        task.command = ["/bin/cat"]
        runTaskAndCheckOnCompletion { (output, ok) -> Void in
            XCTAssertTrue(ok, "cat should have run fine")
            XCTAssertEqual(output, input, "should have piped input to output")
        }
    }
}



extension FoundationTaskTests {
    func runTaskAndCheckOnCompletion(checks: (output: String, ok: Bool) -> Void) {
        let expectingCompletion = expectationWithDescription("\(task) calls completion")
        task.run { [weak expectingCompletion] (output, ok) -> Void in
            guard let completion = expectingCompletion else {
                // If any XCT assertion triggers a failure after the test has finished,
                // the test process will crash with an exception complaining about
                // `'Parameter "test" must not be nil.'`.
                NSLog("completion is nil: aborting")
                return
            }

            checks(output: output, ok: ok)
            completion.fulfill()
        }

        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
    }
}
