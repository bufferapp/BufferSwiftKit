//
//  ProfileGroup.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

struct ProfileGroup: Mappable {
    
    var id: String?
    var name: String?
    var profileIds: [String]?
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
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