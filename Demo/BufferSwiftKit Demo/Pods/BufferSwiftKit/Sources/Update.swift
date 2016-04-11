//
//  Update.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct Update: Mappable {

    public var id: String?
    public var createdAt: NSDate?
    public var day: String?
    public var dueAt: NSDate?
    public var dueTime: NSString?

    public var mediaThumbnailURL: String?
    public var mediaPictureURL: String?

    public var profileId: String?
    public var profileService: String?
    public var pinned: Bool?

    public var sentAt: NSDate?
    public var serviceUpdateId: String?
    public var sharedNow: Bool?
    public var statistics: [String: AnyObject]?
    public var status: String?

    public var text: String?
    public var textFormatted: String?
    public var textMD5: String?

    public var type: String?
    public var updatedAt: NSDate?
    public var userId: String?
    public var via: String?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        id <- map[Keys.id]
        createdAt <- map[Keys.createdAt]
        day <- map[Keys.day]
        dueAt <- map[Keys.dueAt]
        dueTime <- map[Keys.dueAt]
        mediaThumbnailURL <- map[Keys.mediaThumbnailURL]
        mediaPictureURL <- map[Keys.mediaPictureURL]
        profileId <- map[Keys.profileId]
        profileService <- map[Keys.profileService]
        pinned <- map[Keys.pinned]
        sentAt <- map[Keys.sentAt]
        serviceUpdateId <- map[Keys.serviceUpdateId]
        sharedNow <- map[Keys.sharedNow]
        statistics <- map[Keys.statistics]
        status <- map[Keys.status]
        text <- map[Keys.text]
        textFormatted <- map[Keys.textFormatted]
        textMD5 <- map[Keys.textMD5]
        type <- map[Keys.type]
        updatedAt <- map[Keys.updatedAt]
        userId <- map[Keys.userId]
        via <- map[Keys.via]
    }
}

extension Update {
    struct Keys {
        static let id = "id"
        static let createdAt = "created_at"
        static let day = "day"
        static let dueAt = "due_at"
        static let dueTime = "due_time"

        static let mediaThumbnailURL = "media.thumbnail"
        static let mediaPictureURL = "media.picture"

        static let profileId = "profile_id"
        static let profileService = "profile_service"
        static let pinned = "pinned"

        static let sentAt = "sent_at"
        static let serviceUpdateId = "service_update_id"
        static let sharedNow = "share_now"
        static let statistics = "statistics"
        static let status = "status"

        static let text = "text"
        static let textFormatted = "text_formatted"
        static let textMD5 = "text_md5"

        static let type = "type"
        static let updatedAt = "udpated_at"
        static let userId = "user_id"
        static let via = "via"
    }
}
