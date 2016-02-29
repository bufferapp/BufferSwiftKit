//
//  Profile.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Profile: Mappable {

    var avatar: String?
    var created_at: NSDate?
    var coverPhoto: String?
    var defaultProfile: Bool?
    var disconnected: Bool?
    var formattedService: String?
    var formattedUsername: String?
    var id: String?
    var scheduleDays:[String]?
    var scheduleTimes:[String]?
    var service: String?
    var serviceId: String?
    var serviceType: String?
    var serviceUsername: String?
    var statistics: [String: AnyObject]?
    var teamMembers: [TeamMember]?
    var timezone: String?
    var userId: String?
    var verb: String?
    
    
    public init?(_ map: Map) { }
    
    public mutating func mapping(map: Map) {
        avatar <- map[Keys.avatar]
        coverPhoto <- map[Keys.coverPhoto]
        created_at <- (map[Keys.createdAt], DateTransform())
        defaultProfile <- map[Keys.defaultProfile]
        disconnected <- map[Keys.disconnected]
        formattedService <- map[Keys.formattedService]
        formattedUsername <- map[Keys.formattedUsername]
        id <- map[Keys.id]
        scheduleDays <- map[Keys.scheduleDays]
        scheduleTimes <- map[Keys.scheduleTimes]
        service <- map[Keys.service]
        serviceId <- map[Keys.serviceId]
        serviceType <- map[Keys.serviceType]
        serviceUsername <- map[Keys.serviceUsername]
        statistics <- map[Keys.statistics]
        teamMembers <- map[Keys.teamMembers]
        timezone <- map[Keys.timezone]
        userId <- map[Keys.userId]
        verb <- map[Keys.verb]
    }

}

extension Profile {
    struct Keys {
        static let avatar = "avatar"
        static let coverPhoto = "cover_photo"
        static let createdAt = "created_at"
        static let defaultProfile = "default"
        static let disconnected = "disconnected"
        static let formattedService = "formatted_service"
        static let formattedUsername = "formatted_username"
        static let id = "id"
        static let scheduleDays = "schedules.days"
        static let scheduleTimes = "schedules.times"
        static let service = "service"
        static let serviceId = "service_id"
        static let serviceType = "service_type"
        static let serviceUsername = "service_username"
        static let statistics = "statistics"
        static let teamMembers = "team_members"
        static let timezone = "timezone"
        static let userId = "user_id"
        static let verb = "verb"
    }
}