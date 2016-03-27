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
import OAuthSwift
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: BufferClient!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)

        let mainVC = self.setupMainViewController()
        mainVC.automaticallyAdjustsScrollViewInsets = true
        window?.rootViewController = mainVC
        
        LoginManager.setup(mainVC)
        MainHUD.setup(mainVC.view)

        Chameleon.setGlobalThemeUsingPrimaryColor(FlatNavyBlue(), withContentStyle: UIContentStyle.Contrast)

        window!.makeKeyAndVisible()

        return true
    }

    func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
        if (url.host == "oauth-callback") {
            OAuthSwift.handleOpenURL(url)
        }
        return true
    }

    func setupMainViewController() -> UIViewController {
        let queueVC = QueueVC()
        let leftMenuVC = LeftMenuVC()
//        let rightMenuVC = RightMenuVC()
        let nvc = UINavigationController(rootViewController: queueVC)

        return SlideMenuController(mainViewController: nvc, leftMenuViewController: leftMenuVC)
    }
    
}
