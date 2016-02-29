//
//  OperationResult.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/28/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct OperationResult: Mappable {
    var success: Bool?
    var message: String?
    
    public init?(_ map: Map) { }
    
    public mutating func mapping(map: Map) {
        success <- map[Keys.success]
        message <- map[Keys.message]
    }
}

extension OperationResult {
    struct Keys {
        static let success = "success"
        static let message = "message"
    }
}