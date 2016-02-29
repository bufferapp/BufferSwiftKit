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

public protocol BufferClient {
    func getUser(success: (user: User) -> Void, failure: FailureBlock) -> CancellableAction
    func deauthorizeUser(success: (operationResult: OperationResult) -> Void, failure: FailureBlock) -> CancellableAction
    
    func getProfiles(success: (profiles: [Profile]) -> Void, failure: FailureBlock) -> CancellableAction
    func getProfile(id: String, success: (profile: Profile) -> Void, failure: FailureBlock) -> CancellableAction
}

public protocol CancellableAction {
    func cancel()
}

public enum BufferError: ErrorType {
    case JSONParsing(cause: ErrorType)
    case InvalidMapping(json: AnyObject)
    case RequestFailure(cause: ErrorType)
}