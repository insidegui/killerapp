//
//  MenuExtraController.swift
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Cocoa

class MenuExtraController: NSObject {

    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    private let menu = NSMenu()
    
    var shinigamis: [Shinigami]? {
        didSet {
            configureMenu()
        }
    }
    
    init(shinigamis: [Shinigami]?) {
        self.shinigamis = shinigamis
        
        super.init()
        
        statusItem.button?.image = NSImage(named: "headstone")
        
        configureMenu()
    }
    
    private func configureMenu() {
        guard let shinigamis = shinigamis else { return }
        
        for shinigami in shinigamis {
            let item = NSMenuItem(title: shinigami.displayName, action: Selector("shinigamiMenuItemAction:"), keyEquivalent: "")
            if shinigami.requiresAdminPrivileges {
                item.image = NSImage(named: "key")
            }
            item.target = self
            item.representedObject = shinigami
            menu.addItem(item)
        }
        
        menu.addItem(NSMenuItem.separatorItem())
        
        let quitItem = NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: "")
        quitItem.target = NSApp
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    func shinigamiMenuItemAction(sender: NSMenuItem) {
        guard let shinigami = sender.representedObject as? Shinigami else { return }
        
        if shinigami.requiresAdminPrivileges {
            if !runPrivilegedShinigami(shinigami) { NSLog("Shinigami \(shinigami.displayName) failed to execute") }
        } else {
            if !runShinigami(shinigami) { NSLog("Shinigami \(shinigami.displayName) failed to execute") }
        }
    }
    
    private func runPrivilegedShinigami(shinigami: Shinigami) -> Bool {
        let killer = SHPrivilegedKiller()
        
        guard killer.requestAuthorization() else {
            NSLog("Failed to authorize to run shinigami \(shinigami.displayName)")
            return false
        }
        
        return killer.killProcessNamed(shinigami.processName)
    }
    
    private func runShinigami(shinigami: Shinigami) -> Bool {
        let killer = SHKiller()
        
        return killer.killProcessNamed(shinigami.processName)
    }
    
}
