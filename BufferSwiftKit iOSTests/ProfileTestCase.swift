//
//  ProfileTestCase.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import XCTest
import ObjectMapper
import Moya

class ProfileTestCase: XCTestCase {
    func testGetProfileSchedulesWithSuccess() {
        let jsonData = FileUtils.readJSONasData("profile_schedules_success")!
        let httpClient = self.buildBufferClientSubWithResponse(jsonData)
//        let expectedSchedules: [ProfileSchedule] = self.mapDataToJSON(jsonData)
        
        let id = "fakeButValidID"

        httpClient.getProfileSchedules(id, success: { (schedules) -> Void in
            XCTAssertNotNil(schedules)
//            XCTAssert(expectedSchedules == schedules)
        }, failure: { (error) -> Void in
            XCTFail("Error: \(error)")
        })
    }
}
