//
//  ViewController.swift
//  Dark Mode Button
//
//  Created by Uygur Kıran on 18.08.2020.
//  Copyright © 2020 Uygur Kıran. All rights reserved.
//

import Cocoa
import ServiceManagement

class ViewController: NSViewController {

    let helperBundleName = "io.uygur.Dark-Mode-Button--LaunchHelper"
    
    @IBOutlet weak var autoLaunchSwitch: NSSwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let foundHelper = NSWorkspace.shared.runningApplications.contains {
            $0.bundleIdentifier == helperBundleName
        }
        
        autoLaunchSwitch.state = foundHelper ? .on : .off

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    
    @IBAction func toggleAutoLaunch(_ sender: NSSwitch) {
        let isAuto = sender.state == .on
        SMLoginItemSetEnabled(helperBundleName as CFString, isAuto)
        
    }
    
    
    

}

