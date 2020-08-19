//
//  MainVC.swift
//  Dark Mode Button
//
//  Created by Uygur Kıran on 18.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import Cocoa
import ServiceManagement

class MainVC: NSViewController {
    //
    let helperBundleName = "io.uygur.Dark-Mode-Button--LaunchHelper"
    //
    private let dontShowID = "DoNotShowController"
    private let defaults = UserDefaults.standard
    //
    @IBOutlet weak var autoLaunchCheckbox: NSButton!
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //launch launcher
        let foundHelper = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == helperBundleName
        }
        autoLaunchCheckbox.state = foundHelper ? .on : .off
        //
    }
    
    
    //LAUNCH AT LOGIN.
    @IBAction func toggleAutoLaunchaa(_ sender: NSButton) {
        let isAuto = sender.state == .on
        SMLoginItemSetEnabled(helperBundleName as CFString, isAuto)
        
        //don't show the VC at every launch.
        if isAuto {
            defaults.set(true, forKey: dontShowID)
        } else {
            defaults.set(false, forKey: dontShowID)
        }
        //
    }
  
    
}

