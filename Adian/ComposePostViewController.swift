/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
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

