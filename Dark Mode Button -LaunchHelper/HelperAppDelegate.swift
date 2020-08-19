//
//  AppDelegate.swift
//  Dark Mode Button -LaunchHelper
//
//  Created by Uygur Kıran on 19.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import Cocoa

@NSApplicationMain
class HelperAppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //launch the main app, if it is not already running.
        let runningApps = NSWorkspace.shared.runningApplications
           let isRunning = runningApps.contains {
               $0.bundleIdentifier == "io.uygur.Dark-Mode-Button"
           }

           if !isRunning {
               var path = Bundle.main.bundlePath as NSString
               for _ in 1...4 {
                   path = path.deletingLastPathComponent as NSString
               }
               NSWorkspace.shared.launchApplication(path as String)
           }
    
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}

