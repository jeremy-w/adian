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
        let expectingCompletion = expectationWithDescription("\(task) calls completion")
        task.run { [weak expectingCompletion] (output, ok) -> Void in
            XCTAssertTrue(ok, "true should always exit successfully")
            expectingCompletion?.fulfill()
        }
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
    }


    func testDeliversProcessFailureAfterCallingFalse() {
        task.command = ["/usr/bin/false"]
        let expectingCompletion = expectationWithDescription("\(task) calls completion")
        task.run { [weak expectingCompletion] (output, ok) -> Void in
            XCTAssertFalse(ok, "false should always exit unsuccessfully")
            expectingCompletion?.fulfill()
        }
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
    }


    /// Tests it's feeding arguments in appropriately.
    func testDeliversStandardOutputWhenInvokedWithEcho() {
        task.command = ["/usr/bin/false"]
        let expectingCompletion = expectationWithDescription("\(task) calls completion")
        task.run { [weak expectingCompletion] (output, ok) -> Void in
            XCTAssertFalse(ok, "false should always exit unsuccessfully")
            expectingCompletion?.fulfill()
        }
        waitForExpectationsWithTimeout(defaultTimeout, handler: nil)
    }


    /// Tests it's feeding stdin in appropriately.
    func xtestDeliversStandardOutputWhenInvokedWithCat() {
    }
}