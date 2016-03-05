//
//  Utils.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import Moya

func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}
