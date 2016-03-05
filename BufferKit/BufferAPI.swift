//
//  Networking.swift
//  BufferKit
//
//  Created by Humberto Aquino on 2/14/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import Moya

/**
Doc
https://buffer.com/developers/api
*/
public enum BufferAPI: TargetType {
    case User
    case UserDeauthorize

    case Profiles
    case Profile(String)
    case ProfileSchedules(String)
    case ProfileSchedulesUpdate(String, [String: AnyObject])

    case UpdatesPendingForProfile(String, page: Int?, count: Int?, since: Int?, utc: Bool?)
    case Update(String)
    case UpdatesSentForProfile(String, page: Int?, count: Int?, since: Int?, utc: Bool?, filter: String?)
}

public extension BufferAPI {
    var baseURL: NSURL { return NSURL(string: "https://api.bufferapp.com/1")! }

    var path: String {
        switch self {
        case .User:
            return "/user.json"
        case .UserDeauthorize:
            return "/user/deauthorize.json"
        case .Profiles:
            return "/profiles.json"
        case .Profile(let profileId):
            return "/profiles/\(profileId).json"
        case .ProfileSchedules(let profileId):
            return "/profiles/\(profileId)/schedules.json"
        case .ProfileSchedulesUpdate(let profileId, _):
            return "/profiles/\(profileId)/schedules/update.json"
        case .UpdatesPendingForProfile(let profileId, _, _, _, _):
            return "/profiles/\(profileId)/updates/pending.json"
        case .Update(let updateId):
            return "/updates/\(updateId).json"
        case .UpdatesSentForProfile(let profileId, _, _, _, _, _):
            return "/profiles/\(profileId)/updates/sent"
        }
    }

    var method: Moya.Method {
        switch self {
        case .User:
            return .GET
        case .UserDeauthorize:
            return .POST
        case .Profiles:
            return .GET
        case .Profile(_):
            return .GET
        case .ProfileSchedules(_):
            return .GET
        case .ProfileSchedulesUpdate(_):
            return .POST
        case .UpdatesPendingForProfile(_, _, _, _, _):
            return .GET
        case .Update(_):
            return .GET
        case .UpdatesSentForProfile(_, _, _, _, _, _):
            return .GET
        }
    }

    var parameters: [String: AnyObject]? {
        switch self {
        case .UpdatesPendingForProfile(_, let page, let count, let since, let utc):
            let filteredParams = self.filterOptionalParameters([
                "page": page,
                "count": count,
                "since": since,
                "utc": utc
            ])
            return filteredParams
        case .UpdatesSentForProfile(_, let page, let count, let since, let utc, let filter):
            let filteredParams = self.filterOptionalParameters([
                "page": page,
                "count": count,
                "since": since,
                "utc": utc,
                "filter": filter
            ])
            return filteredParams
        case .ProfileSchedulesUpdate(_, let schedules):
            return schedules
        default:
            return nil
        }
    }

    // Not using this but adding a non nil return value to conform protocol
    var sampleData: NSData {
        return "Something".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}

internal extension BufferAPI {
    func filterOptionalParameters(optionalParameters:[String: AnyObject?]) -> [String: AnyObject]? {
        return [:]
    }
}
