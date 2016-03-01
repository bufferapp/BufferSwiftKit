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
        
        httpClient.deauthorizeUser({ (operationResult) -> Void in
            XCTAssertNotNil(operationResult)
            XCTAssert(expectedResult.success! == operationResult.success!)
        }) { (error) -> Void in
            XCTFail("Error: \(error)")
        }
    }

}
