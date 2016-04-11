//
//  Configuration.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper


public struct Configuration: Mappable {

    public var services: [String: AnyObject]?
    public var media: [String: AnyObject]?

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        services <- map[Keys.services]
        media <- map[Keys.media]
    }
}

extension Configuration {
    struct Keys {
        static let services = "services"
        static let media = "media"
    }
}
