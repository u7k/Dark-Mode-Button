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
    //
    //props
    var StatusBarItem: NSStatusItem? = nil
    let buttonMenu = NSMenu()
    let popover = NSPopover()
    //
    private let source = """
    tell application "System Events"
        tell appearance preferences
            set dark mode to not dark mode
        end tell
    end tell
    """
    //
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //button interface
        StatusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        StatusBarItem?.button?.image = NSImage(named: "icon")
        
        //button functionality
        StatusBarItem?.button?.action = #selector(self.buttonClicked(sender:))
        StatusBarItem?.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
        
        //config menu
        buttonMenu.addItem(NSMenuItem(title: "Preferences", action: #selector(popPreferences), keyEquivalent: ""))
        buttonMenu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: ""))
        
        //config popover
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        popover.contentViewController = storyboard.instantiateController(withIdentifier: "MainVCid") as! MainVC
        
        //show popover at launch, if needed.
        if UserDefaults.standard.bool(forKey: "DoNotShowController") != true {
            if let button = StatusBarItem?.button {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
       //
    }
    
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    
    //MARK: - methods
    @objc func buttonClicked(sender: NSStatusBarButton) {
        let event = NSApp.currentEvent!
        //
        //close popover if it's active
        if popover.isShown {
            popover.performClose(sender)
        } else {
            //normal functionality
            //
            if event.type == NSEvent.EventType.rightMouseUp {
                //right click
                //
                //add menu and perform the click
                StatusBarItem?.menu = buttonMenu
                StatusBarItem?.button?.performClick(nil)
                //empty
                StatusBarItem?.menu = nil
            } else {
                //normal click
                //
                changeAppereance()
            }
            
        }
    }
    
    
    //dark mode / light mode
    func changeAppereance() {
        if let script = NSAppleScript(source: source) {
            var error: NSDictionary?
            script.executeAndReturnError(&error)
            if let err = error {
                print(err)
            }
        }
    }
    
    
    //open MainVC
    @objc func popPreferences() {
        if let button = StatusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    
}

