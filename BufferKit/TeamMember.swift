//
//  TeamMember.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

struct TeamMember: Mappable {
    var role: Int?
    var userId: String?
    
    init?(_ map: Map) { }
    
    mutating func mapping(map: Map) {
        role <- map[Keys.role]
        userId <- map[Keys.userId]
    }
}

extension TeamMember {
    struct Keys {
        static let role = "role"
        static let userId = "userId"
    }
}