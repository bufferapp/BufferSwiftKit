//
//  InteractionPage.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct InteractionPage: Mappable {

    var total: Int?
    var interactions: [Interaction]?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        total <- map[Keys.total]
        interactions <- map[Keys.interactions]
    }

}

extension InteractionPage {
    struct Keys {
        static let total = "total"
        static let interactions = "interactions"
    }
}
