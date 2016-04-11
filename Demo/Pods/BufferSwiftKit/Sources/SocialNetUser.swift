//
//  SocialNetUser.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper


public struct SocialNetUser: Mappable {

    public var username: String?
    public var avatarHTTP: String?
    public var avatarHTTPS: String?
    public var twitterId: String?
    public var followers: Int?

    public init?(_ map: Map) {

    }

    public mutating func mapping(map: Map) {
        username <- map[Keys.username]
        avatarHTTP <- map[Keys.avatarHTTP]
        avatarHTTPS <- map[Keys.avatarHTTPS]
        twitterId <- map[Keys.twitterId]
        followers <- map[Keys.followers]
    }
}

extension SocialNetUser {
    struct Keys {
        static let username = "username"
        static let avatarHTTP = "avatar"
        static let avatarHTTPS = "avatar_https"
        static let twitterId = "twitter_id"
        static let followers = "followers"
    }
}
