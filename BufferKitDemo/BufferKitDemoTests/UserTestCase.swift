//
//  UserTestCase.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import XCTest
import ObjectMapper
import Moya

class UserTestCase: XCTestCase {

    func testGetUserWithSuccess() {
        let jsonData = FileUtils.readJSONasData("user_success")!
        let httpClient = self.buildBufferClientSubWithResponse(jsonData)
        let expectedUser: User = self.mapDataToJSON(jsonData)
        
        // Actual API usage
        httpClient.getUser({ (user) -> Void in
            XCTAssertNotNil(user)
            XCTAssert(expectedUser == user)
        }) { (error) -> Void in
            XCTFail("Error: \(error)")
        }
    }
    
    func testGetUserWithError() {
        let jsonData = BufferAPI.User.sampleData
        let httpClient = self.buildBufferClientSubWithResponse(jsonData)
        
        // Actual API usage
        httpClient.getUser({ (user) -> Void in
            XCTFail("Error: It should have failed! \(user))")
        }) { (error) -> Void in
            XCTAssertNotNil(error)
        }
    }
    
    func testUserDeauthorizeSuccess() {
        let jsonData = FileUtils.readJSONasData("user_deauthorize_success")!
        let httpClient = self.buildBufferClientSubWithResponse(jsonData)
        let expectedResult: OperationResult = self.mapDataToJSON(jsonData)
        
        // Actual API usage
        httpClient.deauthorizeUser({ (operationResult) -> Void in
            XCTAssertNotNil(operationResult)
            XCTAssert(expectedResult.success! == operationResult.success!)
        }) { (error) -> Void in
            XCTFail("Error: \(error)")
        }
    }

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
