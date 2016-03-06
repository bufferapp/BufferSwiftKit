//
//  ErrorResult.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/6/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ErrorResult: Mappable {
    var error: String?
    var code: Int?

    var description: String {
        if let code = code, let error = error {
            return "Error: \(error) Code: \(code)"
        } else if let error = error {
            return "Error: \(error)"
        } else if let code = code {
            return "Unknown error. Code: \(code)"
        } else {
            return "Unknown error"
        }
    }

    public init?(_ map: Map) { }

    public mutating func mapping(map: Map) {
        error <- map[Keys.error]
        code <- map[Keys.code]
    }

    public func isValidError() -> Bool {
        if let _ = code, let _ = error {
            return true
        }
        return false
    }
}

extension ErrorResult {
    struct Keys {
        static let error = "error"
        static let code = "code"
    }
}
