//
//  AdianTests.swift
//  AdianTests
//
//  Created by Jeremy on 2015-12-02.
//  Copyright © 2015 Jeremy W. Sherman. All rights reserved.
//

import XCTest
@testable import Adian

class ComposePostViewControllerTests: XCTestCase {

    var composePostViewController: ComposePostViewController!
    
    override func setUp() {
        super.setUp()
        let mainStoryboard = NSStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        composePostViewController = mainStoryboard.instantiateControllerWithIdentifier(ComposePostViewController.storyboardID) as! ComposePostViewController
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testKnowsItsStoryboardID() {
        // passes if we don't explode when as!'ing the ComposePostViewController in setUp()
    }
    
}
