//
//  AppDelegate.swift
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var menuController: MenuExtraController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let builtinShinigamis = [
            Shinigami(displayName: "Restart the Dock", processName: "Dock"),
            Shinigami(displayName: "Restart Finder", processName: "Finder"),
            Shinigami(displayName: "Flush Preferences", processName: "cfprefsd", requiresAdminPrivileges: true),
            Shinigami(displayName: "Fix AppStore Glitch", processName: "storeaccountd")
        ]
        
        menuController = MenuExtraController(shinigamis: builtinShinigamis)
    }
    
    

}

