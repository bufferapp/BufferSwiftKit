//
//  LinkInfo.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct LinkInfo: Mappable {
    var shares: Int?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        shares <- map[Keys.shares]
    }
}

extension LinkInfo {
    struct Keys {
        static let shares = "shares"
    }
}
