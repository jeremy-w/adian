//
//  AppDelegate.swift
//  Adian
//
//  Created by Jeremy on 2015-12-02.
//  Copyright © 2015 Jeremy W. Sherman. All rights reserved.
//

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
