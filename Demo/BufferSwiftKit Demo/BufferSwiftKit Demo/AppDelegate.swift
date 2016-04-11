//
//  AppDelegate.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/14/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import ChameleonFramework
import BufferSwiftKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: BufferClient!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let queueVC = QueueVC()
        window?.rootViewController = UINavigationController(rootViewController: queueVC)

        MainHUD.setup(queueVC.view)

        Chameleon.setGlobalThemeUsingPrimaryColor(FlatNavyBlue(), withContentStyle: UIContentStyle.Contrast)

        AuthManager.sharedManager.accessToken = "Insert token here"

        window!.makeKeyAndVisible()
        
        return true
    }
    
}
