//
//  File.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import OAuthSwift
import Keys

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
  
    private (set) var accessToken: String? {
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

    func doAuth(success:() -> Void, failure:(error: NSError) -> Void) {
        self.status = .InProgress

        let keys = BufferkitdemoKeys()

        let oauthswift = OAuth2Swift(
            consumerKey:    keys.bufferAPIKey(),
            consumerSecret: keys.bufferAPISecret(),
            authorizeUrl:   BufferAPI.AuthURL,
            accessTokenUrl:  "https://api.bufferapp.com/1/oauth2/token.json",
            responseType:   "code"
        )

        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "buffer-kit-demo://oauth-callback/buffer")!,
            scope: "", state:"",
            success: { credential, response, parameters in
                self.accessToken = credential.oauth_token
                self.status = .Authenticated
                success()
            },
            failure: { error in
                print(error.localizedDescription)
                self.accessToken = nil
                self.status = .Failed
                failure(error: error)
            }
        )
        
    }

    func logout() {
        self.accessToken = nil
        self.status = .New
    }
}
