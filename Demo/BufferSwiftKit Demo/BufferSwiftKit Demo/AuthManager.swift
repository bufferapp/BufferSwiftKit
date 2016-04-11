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

    enum AuthStatus {
        case New
        case InProgress
        case Authenticated
        case Failed
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

    private (set) var status: AuthStatus = .New

    var authenticated: Bool {
        return status == .Authenticated
    }

    private init() {
        if let _ = NSUserDefaults.standardUserDefaults().stringForKey(Keys.Token) {
            status = .Authenticated
        }
    }

    func logout() {
        self.accessToken = nil
        self.status = .New
    }
}
