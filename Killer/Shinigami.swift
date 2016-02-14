//
//  Shinigami.swift
//  Killer
//
//  Created by Guilherme Rambo on 14/02/16.
//  Copyright © 2016 Guilherme Rambo. All rights reserved.
//

import Foundation

class Shinigami: NSObject, NSSecureCoding {
    
    var displayName: String
    var processName: String
    var requiresAdminPrivileges: Bool
    
    init(displayName: String, processName: String, requiresAdminPrivileges: Bool = false) {
        self.displayName = displayName
        self.processName = processName
        self.requiresAdminPrivileges = requiresAdminPrivileges
        
        super.init()
    }
    
    // MARK: - NSCoding
    
    private struct Keys {
        static let displayName = "displayName"
        static let processName = "processName"
        static let requiresAdminPrivileges = "requiresAdminPrivileges"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(displayName, forKey: Keys.displayName)
        aCoder.encodeObject(processName, forKey: Keys.processName)
        aCoder.encodeBool(requiresAdminPrivileges, forKey: Keys.requiresAdminPrivileges)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.displayName = aDecoder.decodeObjectForKey(Keys.displayName) as! String
        self.processName = aDecoder.decodeObjectForKey(Keys.processName) as! String
        self.requiresAdminPrivileges = aDecoder.decodeBoolForKey(Keys.requiresAdminPrivileges)
    }
    
    static func supportsSecureCoding() -> Bool {
        return true
    }
    
}