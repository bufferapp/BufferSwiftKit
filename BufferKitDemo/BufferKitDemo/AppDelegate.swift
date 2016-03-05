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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var client: BufferClient!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let token = "1/66d3059be940cb137255ea5fdb0be4e5"
        self.client = MoyaBufferClient(token: token, debug: true)
    
        let profileId = "5683bf9cf9f63ef902e8ee73"
        
//        self.changeProfileSchedule(profileId)
        
        self.getPendingUpdates(profileId)
        
        return true
    }
    
    
    func getProfiles() {
        self.client.getProfiles({ (profiles) -> Void in
            print(profiles)
        }) { (error) -> Void in
            print(error)
        }
    }
    
    func getSchedules(profileId: String) {
        self.client.getProfileSchedules(profileId, success: { (schedules) -> Void in
            print("oh yeah!")
            }, failure: { (error) -> Void in
                print("Oh no!")
        })
    }
    
    func changeProfileSchedule(profileId: String) {
        var sched1:ProfileSchedule = ProfileSchedule(Map(mappingType: MappingType.FromJSON, JSONDictionary: [:]))!
        sched1.days = ["mon", "tue", "wed", "thu", "fri"]
        sched1.times = ["07:36", "20:36"]
        
        var sched2:ProfileSchedule = ProfileSchedule(Map(mappingType: MappingType.FromJSON, JSONDictionary: [:]))!
        sched2.days = ["sat", "sun"]
        sched2.times = ["10:00"]
        
        let schedules:[ProfileSchedule] = [
            sched1,
            sched2
        ]
        
        self.client.setPostingScheduleForProfile(profileId, schedules: schedules, success: { (result) -> Void in
            print("Yes")
            
            self.getSchedules(profileId)
            
            }) { (error) -> Void in
                print("Oh no!")
        }
    }
    
    func getPendingUpdates(profileId: String) {
        self.client.getPendingUpdates(profileId, success: { (udpatePage) -> Void in
            print("Yea!")
        }) { (error) -> Void in
            print(error)
        }
    }
    
}

