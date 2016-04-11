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

    func getPendingUpdates(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, success: (updatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction
    func getPendingUpdates(profileId: String, success: (updatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction

    func getUpdate(updateId: String, success: (update: Update) -> Void, failure: FailureBlock) -> CancellableAction
    func getSentUpdates(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, filter: String?, success: (updatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction
    func getSentUpdates(profileId: String, success: (updatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction

    func getUpdateInteractions(updateId: String, event: InteractionEvent, page: Int?, since: Int?, before: Int?, count: Int?, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction
    func getUpdateInteractions(updateId: String, event: InteractionEvent, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction

    func reorderProfileUpdates(profileId: String, order: [String], offset: Int?, utc: Bool?, success: (updatesResult: UpdatesResult) -> Void, failure: FailureBlock) -> CancellableAction
    func shuffleProfileUpdates(profileId: String, count: Int?, utc: Bool?, success: (updatesResult: UpdatesResult) -> Void, failure: FailureBlock) -> CancellableAction

    func createUpdate(profileIds: [String], text: String?, shorten: Bool?, now: Bool?, top: Bool?, media: [String: String]?, attachment: Bool?,
        scheduledAt: String?, retweet: [String: String]?, success: (updatesResult: UpdatesResult) -> Void, failure: FailureBlock) -> CancellableAction

    func updateUpdate(updateId: String, text: String, now: Bool?, media: [String: String]?, utc: Bool?,
        scheduledAt: String?, success: (updatesResult: UpdatesResult) -> Void, failure: FailureBlock) -> CancellableAction

    func updateShare(updateId: String, success: (result: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction

    func updateDestroy(updateId: String, success: (result: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction

    func updateInteractionCreate(updateId: String, text: String, event: InteractionEvent, success: (singleUpdateResult: SingleUpdateResult) -> Void, failure: FailureBlock) -> CancellableAction

    func linkShares(url: String, success: (linkInfo: LinkInfo) -> Void, failure: FailureBlock) -> CancellableAction

    func getInfoConfiguration(success: (configuration: Configuration) -> Void, failure: FailureBlock) -> CancellableAction

}

public protocol CancellableAction {
    func cancel()
}

public enum BufferError: ErrorType {
    case JSONParsing(cause: ErrorType)
    case InvalidMapping(json: AnyObject)
    case RequestFailure(cause: ErrorType)
}
