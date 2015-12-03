//
//  ViewController.swift
//  Adian
//
//  Created by Jeremy on 2015-12-02.
//  Copyright © 2015 Jeremy W. Sherman. All rights reserved.
//

import Cocoa

class ComposePostViewController: NSViewController {

    static let storyboardID = "Adian.ComposePostViewController"
    static var storyboard: NSStoryboard? {
        let mainStoryboard = NSStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        return mainStoryboard
    }


    static func instantiate() -> ComposePostViewController {
        let instance = storyboard!.instantiateControllerWithIdentifier(storyboardID)
        return instance as! ComposePostViewController
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

