//
//  UpdatePage.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct UpdatePage: Mappable {
    public var total: Int?
    public var updates: [Update]?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        total <- map[Keys.total]
        updates <- map[Keys.updates]
    }
}

extension UpdatePage {
    struct Keys {
        static let total = "total"
        static let updates = "updates"
    }
}
