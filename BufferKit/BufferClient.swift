//
//  BufferClient.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation

// SDK Contract

public typealias FailureBlock = (error: BufferError) -> Void
public typealias SuccessBlock = (success: Bool, message: String)

/**
 Buffer Kit header comment
*/
public protocol BufferClient {
    func getUser(success: (user: User) -> Void, failure: FailureBlock) -> CancellableAction
    func deauthorizeUser(success: (operationResult: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction

    func getProfiles(success: (profiles: [Profile]) -> Void, failure: FailureBlock) -> CancellableAction
    func getProfile(profileId: String, success: (profile: Profile) -> Void, failure: FailureBlock) -> CancellableAction
    func getProfileSchedules(profileId: String, success: (schedules: [ProfileSchedule]) -> Void, failure: FailureBlock) -> CancellableAction
    func setPostingScheduleForProfile(profileId: String, schedules: [ProfileSchedule], success: (result: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction

    func getPendingUpdates(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction
    func getPendingUpdates(profileId: String, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction

    func getUpdate(updateId: String, success: (update: Update) -> Void, failure: FailureBlock) -> CancellableAction
    func getSentUpdates(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, filter: String?, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction
    func getSentUpdates(profileId: String, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction

    func getUpdateInteractions(updateId: String, event: InteractionEvent, page: Int?, since: Int?, before: Int?, count: Int?, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction
    func getUpdateInteractions(updateId: String, event: InteractionEvent, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction

}

public protocol CancellableAction {
    func cancel()
}

public enum BufferError: ErrorType {
    case JSONParsing(cause: ErrorType)
    case InvalidMapping(json: AnyObject)
    case RequestFailure(cause: ErrorType)
}
