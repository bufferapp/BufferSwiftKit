//
//  SuccessUpdate.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct UpdatesResult: Mappable {

    public var success: Bool?
    public var bufferCount: Int?
    public var bufferPercentage: Int?
    public var updates: [Update]?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        success <- map[Keys.success]
        bufferCount <- map[Keys.bufferCount]
        bufferPercentage <- map[Keys.bufferPercentage]
        updates <- map[Keys.updates]
    }
}

extension UpdatesResult {
    struct Keys {
        static let success = "success"
        static let bufferCount = "buffer_count"
        static let bufferPercentage = "buffer_percentage"
        static let updates = "updates"
    }
}
