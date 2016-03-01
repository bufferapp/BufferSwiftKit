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
    
    var id: String?
    var createdAt: NSDate?
    var day: String?
    var dueAt: NSDate?
    var dueTime: NSString?
    
    var mediaThumbnailURL: String?
    var mediaPictureURL: String?
    
    var profileId: String?
    var profileService: String?
    var pinned: Bool?
    
    var sentAt: NSDate?
    var serviceUpdateId: String? // TODO: Is still relevant?
    var sharedNow: Bool?
    var statistics: [String: AnyObject]?
    var status: String?
    
    var text: String?
    var textFormatted: String?
    var textMD5: String?

    var type: String?
    var updatedAt: NSDate?
    var userId: String?
    var via: String?
    
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