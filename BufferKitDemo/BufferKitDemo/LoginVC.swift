//
//  LoginVC.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import JGProgressHUD

class LoginVC: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.initView()
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.initView()
        }
    }

    func initView() {
        let loginView = LoginView()
        loginView.delegate = self
        self.view = loginView
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
    }
}

extension LoginVC: LoginViewDelegate {
    func signInButtonTapped() {
        MainHUD.showMsg("Authenticating")

        AuthManager.sharedManager.doAuth({ () -> Void in
            MainHUD.hide()
            BufferKitManager.sharedInstance.fetchProfiles()
            self.dismissViewControllerAnimated(true) {
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.Auth.SuccessfulLogin, object: nil)
            }
        }) { (error) -> Void in
            MainHUD.hide()
            self.showErrorMsg("Login error", message: error.localizedDescription)
        }
    }
}