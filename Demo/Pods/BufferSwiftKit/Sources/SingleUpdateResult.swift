//
//  SingleSuccessUpdate.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct SingleUpdateResult: Mappable {

    public var success: Bool?
    public var update: Update?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        success <- map[Keys.success]
        update <- map[Keys.update]
    }
}

extension SingleUpdateResult {
    struct Keys {
        static let success = "success"
        static let update = "update"
    }
}
