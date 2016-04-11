//
//  TeamMember.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct TeamMember: Mappable {
    public var role: Int?
    public var userId: String?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
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
