//
//  AppDelegate.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/14/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var httpClient:BufferClient!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let token = "1/66d3059be940cb137255ea5fdb0be4e5"
        
        self.httpClient = MoyaBufferClient(token: token)        
        
        self.httpClient.getUser({ (user) -> Void in
            print(user)
        }, failure: { (error) -> Void in
            print(error)
        })
        
        self.httpClient.getProfiles({ (profiles) -> Void in
            print(profiles)
        }) { (error) -> Void in
            print(error)
        }
    
        return true
    }
}

