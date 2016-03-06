//
//  BufferClient.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

public class MoyaBufferClient {

    var provider: MoyaProvider<BufferAPI>
    private(set) var token: String?

    public init(token: String, debug: Bool = false) {
        self.token = token

        let requestClosure = { (endpoint: Endpoint<BufferAPI>, done: NSURLRequest -> Void) in
            let request = endpoint.urlRequest

            let url = request.URL!
            var newURL = url

            if let _ = url.query {
                newURL = NSURL(string: "\(url.absoluteString)&\(MoyaBufferClient.Params.accessToken)=\(token)")!
            } else {
                newURL = NSURL(string: "\(url.absoluteString)?\(MoyaBufferClient.Params.accessToken)=\(token)")!
            }

            let newRequest = NSMutableURLRequest(URL: newURL)
            newRequest.HTTPMethod = request.HTTPMethod!
            newRequest.HTTPBody = request.HTTPBody

            if let body = request.HTTPBody {
                print(String(data: body, encoding: NSUTF8StringEncoding))
            }
            done(newRequest)
        }

        self.provider = MoyaProvider<BufferAPI>(requestClosure: requestClosure)

        if (debug) {
            let plugin = NetworkLoggerPlugin(verbose: true)
            let plugins:[PluginType] = [plugin]
            self.provider = MoyaProvider<BufferAPI>(requestClosure:requestClosure, plugins: plugins)
        } else {
            self.provider = MoyaProvider<BufferAPI>(requestClosure:requestClosure)

        }

    }

    public init(provider: MoyaProvider<BufferAPI>) {
        self.provider = provider
    }
}

// BufferClient Moya implementation
extension MoyaBufferClient: BufferClient {
    public func getUser(success: (user: User) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestObject(.User, success: success, failure: failure)
    }

    public func deauthorizeUser(success: (operationResult: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestObject(.UserDeauthorize, success: success, failure: failure)
    }

    public func getProfiles(success: (profiles: [Profile]) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestArray(.Profiles, success: success, failure: failure)
    }

    public func getProfile(profileId: String, success: (profile: Profile) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestObject(.Profile(profileId), success: success, failure: failure)
    }

    public func getProfileSchedules(profileId: String, success: (schedules: [ProfileSchedule]) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestArray(.ProfileSchedules(profileId), success: success, failure: failure)
    }

    public func getPendingUpdates(profileId: String, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.getPendingUpdates(profileId, page: nil, count: nil, since: nil, utc: nil, success: success, failure: failure)
    }

    public func getPendingUpdates(profileId: String, page: Int? = nil, count: Int? = nil, since: Int? = nil, utc: Bool? = nil, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .UpdatesPendingForProfile(profileId, page: page, count: count, since: since, utc: utc)
        return self.requestObject(target, success: success, failure: failure)
    }

    public func getUpdate(updateId: String, success: (update: Update) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestObject(.Update(updateId), success: success, failure: failure)
    }

    public func setPostingScheduleForProfile(profileId: String, schedules: [ProfileSchedule], success: (result: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction {

        var parameters: [String: AnyObject] = [:]

        // Build parameters of schedules with days and times only
        for (index, schedule) in schedules.enumerate() {
            if let days = schedule.days, times = schedule.times {
                let daysKey = "schedules[\(index)][days]"
                parameters[daysKey] = days
                let timesKey = "schedules[\(index)][times]"
                parameters[timesKey] = times
            }
        }

        return self.requestObject(.ProfileSchedulesUpdate(profileId, parameters), success: success, failure: failure)
    }

    public func getSentUpdates(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, filter: String?, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .UpdatesSentForProfile(profileId, page: page, count: count, since: since, utc: utc, filter: filter)
        return self.requestObject(target, success: success, failure: failure)
    }

    public func getSentUpdates(profileId: String, success: (udpatePage: UpdatePage) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.getSentUpdates(profileId, page: nil, count: nil, since: nil, utc: nil, filter: nil, success: success, failure: failure)
    }

    public func getUpdateInteractions(updateId: String, event: InteractionEvent, page: Int?, since: Int?, before: Int?, count: Int?, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .UpdateInteractions(updateId: updateId, event: event.rawValue, page: page, since: since, before: before, count: count)
        return self.requestObject(target, success: success, failure: failure)
    }

    public func getUpdateInteractions(updateId: String, event: InteractionEvent, success: (interactionPage: InteractionPage) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.getUpdateInteractions(updateId, event: event, page: nil, since: nil, before: nil, count: nil, success: success, failure: failure)
    }

    public func reorderProfileUpdates(profileId: String, order: [String], offset: Int?, utc: Bool?, success: (successUpdate: SuccessUpdate) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .ProfileUpdatesReorder(profileId: profileId, order: order, offset: offset, utc: utc)
        return self.requestObject(target, success: success, failure: failure)
    }

    public func shuffleProfileUpdates(profileId: String, count: Int?, utc: Bool?, success: (successUpdate: SuccessUpdate) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .ProfileUpdatesShuffle(profileId: profileId, count: count, utc: utc)
        return self.requestObject(target, success: success, failure: failure)
    }

    public func createUpdate(profileIds: [String], text: String?, shorten: Bool?, now: Bool?, top: Bool?, media: [String : String]?, attachment: Bool?,
        scheduledAt: String?, retweet: [String : String]?, success: (successUpdate: SuccessUpdate) -> Void, failure: FailureBlock) -> CancellableAction {
        let target: BufferAPI = .UpdateCreate(profileIds: profileIds, text: text, shorten: shorten, now: now, top: top,
            media: media, attachment: attachment, scheduledAt: scheduledAt, retweet: retweet)
        return self.requestObject(target, success: success, failure: failure)
    }

}

// core methods for the moya client
extension MoyaBufferClient {
    func requestArray<T: Mappable>(target: BufferAPI, success: (result: [T]) -> Void, failure: (error: BufferError) -> Void) -> CancellableAction {
        let cancellable = self.requestJSON(target, success: { (json) -> Void in
            if let error = self.jsonResponseAsError(json) {
                failure(error: error)
                return
            }

            if let result:[T] = Mapper<T>().mapArray(json) {
                success(result: result)
            } else {
                failure(error: BufferError.InvalidMapping(json: json))
            }
            }, failure: { (error) -> Void in
                failure(error: error)
        })

        return cancellable
    }

    func requestObject<T: Mappable>(target: BufferAPI, success: (result: T) -> Void, failure: (error: BufferError) -> Void) -> CancellableAction {
        let cancellable = self.requestJSON(target, success: { (json) -> Void in
            if let error = self.jsonResponseAsError(json) {
                failure(error: error)
                return
            }

            if let result = Mapper<T>().map(json) {
                success(result: result)
            } else {
                failure(error: BufferError.InvalidMapping(json: json))
            }
        }, failure: { (error) -> Void in
            failure(error: error)
        })

        return cancellable
    }

    func requestJSON(target: BufferAPI, success: (json: AnyObject) -> Void, failure: (error: BufferError) -> Void) -> CancellableAction {
        let cancellable = self.provider.request(target, completion: { result in
            switch result {
            case let .Success(response):
                do {
                    let json = try response.mapJSON()
                    success(json: json)
                } catch (let error) {
                    failure(error: BufferError.JSONParsing(cause: error))
                }
            case let .Failure(error):
                failure(error: BufferError.RequestFailure(cause: error))
            }
        })
        return CancellableWrapper(cancellable: cancellable)
    }

    func jsonResponseAsError(json: AnyObject) -> BufferError? {
        if let result: ErrorResult = Mapper<ErrorResult>().map(json) {
            if result.isValidError() {
                return self.buildBufferErrorWith(result)
            }
        }
        return nil
    }

    func buildBufferErrorWith(errorResult: ErrorResult) -> BufferError {
        let errorMsg = errorResult.description
        let userInfo = [
            NSLocalizedDescriptionKey: errorMsg
        ]
        let error = NSError(domain: "domain", code: 1001, userInfo: userInfo)
        let bufferError = BufferError.RequestFailure(cause: error)
        return bufferError
    }
}



// Params
extension MoyaBufferClient {
    struct Params {
        static let accessToken = "access_token"
    }
}

// Cancel wrapper
struct CancellableWrapper: CancellableAction {
    let cancellable: Cancellable

    init(cancellable: Cancellable) {
        self.cancellable = cancellable
    }

    func cancel() {
        self.cancellable.cancel()
    }
}
