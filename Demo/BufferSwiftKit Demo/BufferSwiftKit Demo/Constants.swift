//
//  Constants.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/25/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation

struct Notification {

    struct Auth {
        static let NoExitingToken = "bsk.notification.auth.noExistingToken"
        static let SuccessfulLogin = "bsk.notification.auth.successfulLogin"
        static let SuccessfulLogout = "bsk.notification.auth.successfulLogout"
    }

    struct Profile {
        static let UpdateSuccess = "bsk.notification.profile.updateSuccess"
        static let UpdateFailed = "bsk.notification.profile.updateFailed"
    }

    struct Update {
        static let UpdateSuccess = "bsk.notification.update.updateSuccess"
        static let UpdateFailed = "bsk.notification.update.updateFailed"
    }

}