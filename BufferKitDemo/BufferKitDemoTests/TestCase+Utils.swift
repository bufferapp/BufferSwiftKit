//
//  TestCase+Utils.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import XCTest
import Moya
import ObjectMapper

extension XCTestCase {
    func mapDataToJSON<T: Mappable>(data: NSData) -> T {
        let json = String(data: data, encoding: NSUTF8StringEncoding)!
        let expectedUser = Mapper<T>().map(json)!
        return expectedUser
    }
    
    func buildBufferClientSubWithResponse(data: NSData) -> BufferClient {
        let fakeEndpointsClosure = { (target: BufferAPI) -> Endpoint<BufferAPI> in
            return Endpoint<BufferAPI>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, data)}, method: target.method, parameters: target.parameters)
        }
        let provider = MoyaProvider<BufferAPI>(endpointClosure: fakeEndpointsClosure, stubClosure: MoyaProvider.ImmediatelyStub)
        let httpClient:BufferClient = MoyaBufferClient(provider: provider)
        
        return httpClient
    }
}