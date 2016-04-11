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

    static let AuthURL = "https://bufferapp.com/oauth2/authorize"

    // https://buffer.com/developers/api/user
    case User
    case UserDeauthorize

    // https://buffer.com/developers/api/profiles
    case Profiles
    case Profile(profileId: String)
    case ProfileSchedules(profileId: String)
    case ProfileSchedulesUpdate(profileId: String, schedules: [String: AnyObject])
    case UpdatesPendingForProfile(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?)
    case Update(updateId: String)
    case UpdatesSentForProfile(profileId: String, page: Int?, count: Int?, since: Int?, utc: Bool?, filter: String?)
    case UpdateInteractions(updateId: String, event: String, page: Int?, since: Int?, before: Int?, count: Int?)
    case ProfileUpdatesReorder(profileId: String, order: [String], offset: Int?, utc: Bool?)
    case ProfileUpdatesShuffle(profileId: String, count: Int?, utc: Bool?)

    // https://buffer.com/developers/api/updates
    case UpdateCreate(profileIds: [String], text: String?, shorten: Bool?, now: Bool?, top: Bool?,
        media: [String: String]?, attachment: Bool?, scheduledAt: String?, retweet: [String: String]?)
    case UpdateUpdate(updateId: String, text: String, now: Bool?, media: [String: String]?, utc: Bool?, scheduledAt: String?)
    case UpdateShare(updateId: String)
    case UpdateDestroy(updateId: String)
    case UpdateMoveToTop(updateId: String)
    case UpdateInteractionsCreate(updateId: String, text: String, event: String)

    // https://buffer.com/developers/api/links
    case LinkShares(url: String)

    case InfoConfiguration
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
            return "/profiles/\(profileId)/updates/sent.json"
        case .UpdateInteractions(let updateId, _, _, _, _, _):
            return "/updates/\(updateId)/interactions.json"
        case .ProfileUpdatesReorder(let profileId, _, _, _):
            return "/profiles/\(profileId)/updates/reorder.json"
        case .ProfileUpdatesShuffle(let profileId, _, _):
            return "/profiles/\(profileId)/updates/shuffle.json"
        case .UpdateCreate(_, _, _, _, _, _, _, _, _):
            return "/updates/create.json"
        case UpdateUpdate(let updateId, _, _, _, _, _):
            return "/updates/\(updateId)/update.json"
        case .UpdateShare(let updateId):
            return "/updates/\(updateId)/share.json"
        case .UpdateDestroy(let updateId):
            return "/updates/\(updateId)/destroy.json"
        case .UpdateMoveToTop(let updateId):
            return "/updates/\(updateId)/move_to_top.json"
        case .UpdateInteractionsCreate(let updateId, _, _):
            return "/updates/\(updateId)/interactions/create.json"
        case LinkShares(_):
            return "/links/shares.json"
        case InfoConfiguration:
            return "/info/configuration.json"
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
        case .UpdateInteractions(_, _, _, _, _, _):
            return .GET
        case .ProfileUpdatesReorder(_, _, _, _):
            return .POST
        case .ProfileUpdatesShuffle(_, _, _):
            return .POST
        case .UpdateCreate(_, _, _, _, _, _, _, _, _):
            return .POST
        case UpdateUpdate(_, _, _, _, _, _):
            return .POST
        case .UpdateShare(_):
            return .POST
        case .UpdateDestroy(_):
            return .POST
        case .UpdateMoveToTop(_):
            return .POST
        case .UpdateInteractionsCreate(_, _, _):
            return .POST
        case .LinkShares(_):
            return .GET
        case .InfoConfiguration:
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

        case .UpdateInteractions(_, let event, let page, let since, let before, let count):
            let filteredParams = self.filterOptionalParameters([
                "event": event,
                "page": page,
                "since": since,
                "before": before,
                "count": count
            ])
            return filteredParams
        case .ProfileUpdatesReorder(_, let order, let offset, let utc):
            let filteredParams = self.filterOptionalParameters([
                "order": order,
                "offset": offset,
                "utc": utc
                ])
            return filteredParams
        case .ProfileUpdatesShuffle(_, let count, let utc):
            let filteredParams = self.filterOptionalParameters([
                "count": count,
                "utc": utc
                ])
            return filteredParams
        case .UpdateCreate(let profileIds, let text, let shorten, let now, let top, let media, let attachment, let scheduledAt, let retweet):
            let filteredParams = self.filterOptionalParameters([
                "profile_ids": profileIds,
                "text": text,
                "shorten": shorten,
                "now": now,
                "top": top,
                "media": media,
                "attachment": attachment,
                "scheduled_at": scheduledAt,
                "retweet": retweet
                ])
            return filteredParams
        case .UpdateUpdate(_, let text, let now, let media, let utc, let scheduledAt):
            let filteredParams = self.filterOptionalParameters([
                "text": text,
                "now": now,
                "media": media,
                "utc": utc,
                "scheduled_at": scheduledAt
                ])
            return filteredParams
        case .UpdateInteractionsCreate(_, let text, let event):
            let filteredParams = self.filterOptionalParameters([
                "text": text,
                "event": event
                ])
            return filteredParams

        case .LinkShares(let url):
            return ["url": url]
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
        var nonOptionalParams: [String: AnyObject] = [:]

        for (key, value) in optionalParameters {
            if let value = value {
                nonOptionalParams[key] = value
            }
        }

        if nonOptionalParams.isEmpty {
            return nil
        }

        return nonOptionalParams
    }
}
