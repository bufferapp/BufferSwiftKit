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
    var createdAt: NSDate?
    var coverPhoto: String?
    var defaultProfile: Bool?
    var disconnected: Bool?
    var formattedService: String?
    var formattedUsername: String?
    var id: String?
    var schedules:[ProfileSchedule]?

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
        createdAt <- (map[Keys.createdAt], DateTransform())
        defaultProfile <- map[Keys.defaultProfile]
        disconnected <- map[Keys.disconnected]
        formattedService <- map[Keys.formattedService]
        formattedUsername <- map[Keys.formattedUsername]
        id <- map[Keys.id]
        schedules <- map[Keys.schedules]
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
        static let schedules = "schedules"
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
