//
//  MenuHeaderCellView.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/26/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit

class MenuHeaderHFV: UITableViewHeaderFooterView {

    static let CellIdentifier = "MenuHeaderCellIdentifier"

    func configWithProfile(profile: Profile?) {
        if let profile = profile {
            self.textLabel?.text = "Current: \(profile.formattedUsername!)"
        } else {
            self.textLabel?.text = "No profiles. Please refresh"
        }
    }

}