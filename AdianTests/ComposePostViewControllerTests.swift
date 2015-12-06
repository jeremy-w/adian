//
//  AdianTests.swift
//  AdianTests
//
//  Created by Jeremy on 2015-12-02.
//  Copyright © 2015 Jeremy W. Sherman. All rights reserved.
//

import XCTest
@testable import Adian

let AnyMessage = "testing!"

class SpyPoster: Poster {
    var receivedMessage: String?
    func postMessage(message: String) {
        receivedMessage = message
    }
}


class ComposePostViewControllerTests: XCTestCase {

    var composePostViewController: ComposePostViewController!
    var spyPoster = SpyPoster()

    override func setUp() {
        super.setUp()
        composePostViewController = ComposePostViewController.instantiate()
        composePostViewController.configure(spyPoster)
    }

    override func tearDown() {
        super.tearDown()
    }


    func testKnowsItsStoryboardID() {
        // passes if we don't explode when as!'ing the ComposePostViewController in setUp()
    }


    func testHasASendButton() {
        havingLoadedItsView()
        XCTAssertNotNil(composePostViewController.sendButton, "nil sendButton")
    }


    func testSendButtonIsDefaultButton() {
        havingLoadedItsView()
        XCTAssertEqual(composePostViewController.sendButton.keyEquivalent, "\r")
    }


    func testHasMessageField() {
        havingLoadedItsView()
        XCTAssertNotNil(composePostViewController.messageField, "nil messageField")
    }


    func testPressingSendButtonSuppliesTextToPoster() {
        havingLoadedItsView()
        havingTyped(AnyMessage)

        composePostViewController.sendButton.performClick(nil)

        XCTAssertEqual(spyPoster.receivedMessage, AnyMessage)
    }


    func havingLoadedItsView() {
        _ = composePostViewController.view
    }


    func havingTyped(message: String) {
        composePostViewController.messageField.insertText(message)
    }
    
}
