//
//  BufferKitManager.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/26/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import Foundation
import BufferSwiftKit

class BufferKitManager {

    var bufferClient: BufferClient!

    private (set) var profiles: [Profile]!
    private (set) var pendingUpdatePage: UpdatePage!

    // Singleton declaration
    static let sharedInstance = BufferKitManager()
    private init() { }

    var fetchProfilesCancellable: CancellableAction?
    var fetchPendingUpdatesCancellable: CancellableAction?

    var isFetchingProfiles: Bool {
        if let _ = fetchProfilesCancellable {
            return true
        }
        return false
    }
    var isFetchingPendingUpdates: Bool {
        if let _ = fetchPendingUpdatesCancellable {
            return true
        }
        return false
    }

    var selectedProfile: Profile?

    func currentProfile() -> Profile? {
        if let selectedProfile = selectedProfile {
            return selectedProfile
        }
        if let profiles = profiles {
            if profiles.count > 0 {
                selectedProfile = profiles[0]
                return selectedProfile
            }
        }
        return nil
    }

    func fetchProfiles() {
        performRequest() {
            self.fetchProfilesAndPendingUpdates()
        }
    }

    func logout(completion:((success: Bool, error: BufferError?)-> Void)) {
        bufferClient.deauthorizeUser({ (operationResult) in
            completion(success: true, error: nil)
        }) { (error) in
            completion(success: false, error: error)
        }

    }

    func performRequest(operation:(() -> Void)) {
        if (self.bufferClient == nil) {
            if let token = AuthManager.sharedManager.accessToken {
                self.bufferClient = MoyaBufferClient(token: token)
                operation()
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(Notification.Auth.NoExitingToken, object: nil)
            }
        } else {
            operation()
        }
    }

    func reset() {
        pendingUpdatePage = nil
        profiles = nil
        fetchPendingUpdatesCancellable?.cancel()
        fetchProfilesCancellable?.cancel()
        bufferClient = nil
    }

    func fetchUpdatesForProfile(profile: Profile) {
        selectedProfile = profile
        fetchPendingUpdatesSelectedProfile()
    }

    private func fetchProfilesAndPendingUpdates(){
        if isFetchingProfiles {
            return
        }

        fetchProfilesCancellable = self.bufferClient.getProfiles({ (profiles) -> Void in
            self.profiles = profiles
            NSNotificationCenter.defaultCenter().postNotificationName(Notification.Profile.UpdateSuccess, object: nil)
            self.fetchPendingUpdatesSelectedProfile()
            self.fetchProfilesCancellable = nil
        }, failure: { (error) -> Void in
            // TODO: Pass error
            NSNotificationCenter.defaultCenter().postNotificationName(Notification.Profile.UpdateFailed, object: nil)
            self.fetchProfilesCancellable = nil
        })
    }

    func fetchPendingUpdatesSelectedProfile() {
        performRequest() {
            if self.isFetchingPendingUpdates {
                return
            }

            // Only get the default one
            if let currentProfile = self.currentProfile() {
                if let profileId = currentProfile.id {
                    // TODO: Only update if note running
                    self.fetchPendingUpdatesCancellable = self.bufferClient.getPendingUpdates(profileId, success: { (updatePage) -> Void in
                        // success!
                        self.pendingUpdatePage = updatePage

                        NSNotificationCenter.defaultCenter().postNotificationName(Notification.Update.UpdateSuccess, object: nil)
                        self.fetchPendingUpdatesCancellable = nil
                        }, failure: { (error) -> Void in
                            // TODO: Pass error
                            NSNotificationCenter.defaultCenter().postNotificationName(Notification.Update.UpdateFailed, object: nil)
                            self.fetchPendingUpdatesCancellable = nil
                    })
                } else {
                    // TODO: Provide error
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.Update.UpdateFailed, object: nil)
                }
            }
        }
    }


}