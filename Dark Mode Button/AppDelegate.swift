//
//  AppDelegate.swift
//  Dark Mode Button
//
//  Created by Uygur Kıran on 18.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

     //props
        var StatusBarItem: NSStatusItem? = nil
        private let source = """
    tell application "System Events"
        tell appearance preferences
            set dark mode to not dark mode
        end tell
    end tell
    """

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //dark mode button
         StatusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
         
        // StatusBarItem?.button?.image = NSImage(named: "")
         StatusBarItem?.button?.title = "changeMode"
         StatusBarItem?.button?.action = #selector(changeAppereance)
        


    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    //MARK: - method
       @objc func changeAppereance() {
           if let script = NSAppleScript(source: source) {
                      var error: NSDictionary?
                      script.executeAndReturnError(&error)
                      if let err = error {
                       print(err)
                      }
                  }
           
       }

} //end

