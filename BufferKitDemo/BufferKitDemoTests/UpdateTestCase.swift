//
//  UpdateTestCase.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/1/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import XCTest
import ObjectMapper
import Moya

class UpdateTestCase: XCTestCase {
    func testGetUpdatesForProfileWithSuccess() {
        let jsonData = FileUtils.readJSONasData("profile_updates_success")!
        let httpClient = self.buildBufferClientSubWithResponse(jsonData)
        //        let expectedSchedules: [ProfileSchedule] = self.mapDataToJSON(jsonData)
        
        let id = "fakeButValidID"
        
        httpClient.getPendingUpdates(id, success: { (updatePage) -> Void in
            XCTAssertNotNil(updatePage.updates)
            XCTAssert(updatePage.updates!.count == 10, "There should be 10 updates")
        }, failure: { (error) -> Void in
            XCTFail("Error: \(error)")
        })
        
    }
}
