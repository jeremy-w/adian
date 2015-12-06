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


    /// Provides required components not embedded in the storyboard.
    ///
    /// Commonly called from `prepareForSegue(_:sender:)`.
    func configure(poster: Poster) {
        self.poster = poster
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


    // MARK: Enter Post
    @IBOutlet var messageField: NSTextView!


    // MARK: Send Post
    @IBOutlet var sendButton: NSButton!
    var poster: Poster?

    @IBAction func sendButtonAction(sender: NSButton?) {
        sendMessage()
    }

    func sendMessage() {
        let message = messageField.string ?? ""
        poster?.postMessage(message)
    }


}

