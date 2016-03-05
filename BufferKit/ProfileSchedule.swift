//
//  PorfileSchedule.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ProfileSchedule: Mappable {

    var days: [String]?
    var times: [String]?

   public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        days <- map[Keys.days]
        times <- map[Keys.times]
    }
}

extension ProfileSchedule {
    struct Keys {
        static let times = "times"
        static let days = "days"
    }
}

extension ProfileSchedule {
    public func asDict() -> [String: AnyObject] {
        var dict:[String: AnyObject] = [:]
        dict[Keys.days] = days  ?? []
        dict[Keys.times] = times ?? []
        return dict
    }
}
