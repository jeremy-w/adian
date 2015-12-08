/*
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
*/
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // What the heck? You can't connect an outlet to the main view controller,
        // and you can't actually grab a list of view controllers anywhere.
        //
        // Guess it's fishing time!
        //
        // This is only temporary till we start vending compose post VCs properly, anyway.
        guard let
            window = NSApp.windows.first,
            view = window.contentView,
            viewController = view.nextResponder as? ComposePostViewController
        else {
            NSLog("failed to dig up compose post view controller")
            return
        }

        configureComposePostViewController(viewController)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }

    func configureComposePostViewController(vc: ComposePostViewController) {
        vc.configure(Wry(task: FoundationTask()))
    }

}
