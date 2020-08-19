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
    let buttonMenu = NSMenu()
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
        StatusBarItem?.button?.image = NSImage(named: "icon")
        
        //button functionality
        StatusBarItem?.button?.action = #selector(self.buttonClicked(sender:))
        StatusBarItem?.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
        
        //config menu
        buttonMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    
    //MARK: - methods
    @objc func buttonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        
        if event.type == NSEvent.EventType.rightMouseUp {
            //right click
            //add menu and perform the click
            StatusBarItem?.menu = buttonMenu
            StatusBarItem?.button?.performClick(nil)
            //empty
            StatusBarItem?.menu = nil
        } else {
            //normal click
            changeAppereance()
        }
    }
    
    func changeAppereance() {
        if let script = NSAppleScript(source: source) {
            var error: NSDictionary?
            script.executeAndReturnError(&error)
            if let err = error {
                print(err)
            }
        }
        
    }
    
} //end

