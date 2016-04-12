//
//  File.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation

class AuthManager {

    struct Keys {
        static let Token = "AuthManager.Token"
    }

    static let sharedManager = AuthManager()
  
    var accessToken: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey(Keys.Token)
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: Keys.Token)
        }
    }

    var authenticated: Bool {
        if let _ = self.accessToken {
            return true
        }
        return false
    }

    private init() {
        if let _ = NSUserDefaults.standardUserDefaults().stringForKey(Keys.Token) {

        }
    }

    func logout() {
        self.accessToken = nil
    }
}
