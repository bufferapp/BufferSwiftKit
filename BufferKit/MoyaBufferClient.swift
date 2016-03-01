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

    public init(token: String) {
        self.token = token

        let endpointClosure:(BufferAPI) -> Endpoint<BufferAPI> = { (target: BufferAPI) -> Endpoint<BufferAPI> in
            var enhancedParameters:[String: AnyObject] = [:]
            if let parameters = target.parameters {
                enhancedParameters = parameters
            }
            // Append the token, always
            enhancedParameters[MoyaBufferClient.Params.accessToken] = token
            
            let url = target.baseURL.URLByAppendingPathComponent(target.path).absoluteString
            return Endpoint(URL: url, sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: enhancedParameters)
        }
        self.provider = MoyaProvider<BufferAPI>(endpointClosure:endpointClosure)
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
        return self.requestObject(.UpdatesPendingForProfile(profileId), success: success, failure: failure)
    }
    
    public func getUpdate(updateId: String, success: (update: Update) -> Void, failure: FailureBlock) -> CancellableAction {
        return self.requestObject(.Update(updateId), success: success, failure: failure)
    }
}

// core methods for the moya client
extension MoyaBufferClient {
    func requestArray<T: Mappable>(target: BufferAPI, success: (result: [T]) -> Void, failure: (error: BufferError) -> Void) -> CancellableAction {
        let cancellable = self.requestJSON(target, success: { (json) -> Void in
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