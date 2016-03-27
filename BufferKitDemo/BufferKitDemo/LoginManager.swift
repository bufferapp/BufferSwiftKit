//
//  LoginManager.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit

class LoginManager: NSObject {

    var rootViewController: UIViewController!
    var loginVCActive = false

    static let sharedManager = LoginManager()
    private override init() { }

    class func setup(rootViewController: UIViewController) {
        sharedManager.rootViewController = rootViewController
        sharedManager.subscribeToCoreNotifications()
    }

    func subscribeToCoreNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginManager.handleNoExistingToken(_:)), name: Notification.Auth.NoExitingToken, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginManager.handleSuccessfulLogin(_:)), name: Notification.Auth.SuccessfulLogin, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginManager.handleSuccessfulLogout(_:)), name: Notification.Auth.SuccessfulLogout, object: nil)
    }

    func handleNoExistingToken(notification: NSNotification) {
        presentLoginVCIfNecessary()
    }

    func handleSuccessfulLogout(notification: NSNotification) {
        presentLoginVCIfNecessary()
    }
    
    func handleSuccessfulLogin(notification: NSNotification) {
        loginVCActive = false
        BufferKitManager.sharedInstance.fetchProfiles()
    }

    func presentLoginVCIfNecessary() {
        switch AuthManager.sharedManager.status {
        case .New, .Failed:
            presentLoginVC()
        default:
            // Do nothing
            break
        }
    }

    private func presentLoginVC() {
        if !loginVCActive {
            loginVCActive = true
            let loginVC = LoginVC()
            rootViewController.presentViewController(loginVC, animated: true, completion: nil)
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}