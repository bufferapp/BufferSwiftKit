//
//  User.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation

import ObjectMapper

public struct User: Mappable {
    
    var _id: String?
    var activityAt: NSDate?
    var created_at: NSDate?
    var id: String?
    var plan: String?
    var timezone: String?
    
    var name: String?
    var profileGroups: [ProfileGroup]?
    
    public init?(_ map: Map) { }
    
    public mutating func mapping(map: Map) {
        _id <- map[Keys._id]
        activityAt <- (map[Keys.activityAt], DateTransform())
        created_at <- (map[Keys.createdAt], DateTransform())
        id <- map[Keys.id]
        plan <- map[Keys.plan]
        timezone <- map[Keys.timezone]
        name <- map[Keys.name]
        profileGroups <- map[Keys.profileGroups]
    }
}

extension User {
    struct Keys {
        static let _id = "_id"
        static let activityAt = "activity_at"
        static let createdAt = "created_at"
        static let id = "id"
        static let plan = "plan"
        static let timezone = "timezone"
        static let name = "name"
        static let profileGroups = "profile_groups"
    }
}

extension User: Equatable {
    func equals(otherUser: User) -> Bool {
        // Equal id, equal objects for now
        if self.id != nil && otherUser.id != nil
            && self.id == self.id {
           return true
        } else {
            return false
        }
    }
}

public func ==(lhs:User, rhs:User) -> Bool {
    return lhs.equals(rhs)
}
