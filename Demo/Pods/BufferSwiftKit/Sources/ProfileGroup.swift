//
//  ProfileGroup.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ProfileGroup: Mappable {

    public var id: String?
    public var name: String?
    public var profileIds: [String]?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        id <- map[Keys.id]
        name <- map[Keys.name]
        profileIds <- map[Keys.profileIds]
    }

}

extension ProfileGroup {
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let profileIds = "profile_ids"
    }
}
