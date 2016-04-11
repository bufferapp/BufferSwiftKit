//
//  ProfileMenuVC.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import JGProgressHUD
import BufferSwiftKit

class ProfileMenuVC: UIViewController {

    let HUD = JGProgressHUD(style: .Dark)
    
    let FooterCellIdentifier = "FooterCellIdentifier"
    let ProfileCellIdentifier = "ProfileCellIdentifier"
    let ContentHeaderIdentifier = "ContentHeaderIdentifier"

    enum Section: Int {
        case Content = 0
        case Footer = 1
    }

    weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!

    var profiles: [Profile]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

        navigationItem.title = "Select a Profile"

        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.setupView()
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profilesUpdated(_:)), name: Notification.Profile.UpdateSuccess, object: nil)

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(ProfileMenuVC.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
    }

    func setupView() {
        let queueView = QueueView()
        tableView = queueView.tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() 
        view = queueView

        // Register table views
        tableView.registerClass(MenuHeaderHFV.self, forHeaderFooterViewReuseIdentifier: MenuHeaderHFV.CellIdentifier)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ProfileCellIdentifier)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: FooterCellIdentifier)
    }

    override func viewWillAppear(animated: Bool) {
        refreshProfiles()
    }

    func profilesUpdated(notificaiton: NSNotification) {
        refreshProfiles()
    }

    func refreshProfiles() {
        self.profiles = BufferKitManager.sharedInstance.profiles
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        BufferKitManager.sharedInstance.fetchProfiles()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func swithToProfile(profile: Profile) {
        MainHUD.showMsg("Fetching \(profile.summary)")
        BufferKitManager.sharedInstance.fetchUpdatesForProfile(profile)
        tableView.reloadData() // To refresh the selected profile
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ProfileMenuVC: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.init(rawValue: section)! {
        case Section.Content:
            // Profile list
            return profiles?.count ?? 0
        default:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForContentOn(indexPath)
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch Section.init(rawValue: section)! {
        case Section.Content:
            return headerViewForContent()
        case Section.Footer:
            return nil
        }
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch Section.init(rawValue: section)! {
        case Section.Content:
            return 40
        default:
            return 0
        }
    }

    func headerViewForContent() -> UIView {
        let menuHeader = tableView.dequeueReusableHeaderFooterViewWithIdentifier(MenuHeaderHFV.CellIdentifier) as! MenuHeaderHFV

        let profile = BufferKitManager.sharedInstance.currentProfile()
        menuHeader.configWithProfile(profile)

        return menuHeader
    }

    func cellForContentOn(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ProfileCellIdentifier, forIndexPath: indexPath)
        let profile = profiles![indexPath.row]

        if let username = profile.formattedUsername, let service = profile.formattedService {
            cell.textLabel?.text = "\(username) - \(service)"
        } else {
            cell.textLabel?.text = "Opps"
        }

        if let selectedProfile = BufferKitManager.sharedInstance.selectedProfile {
            if selectedProfile.id != nil && selectedProfile.id == profile.id {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }

        return cell
    }

}

extension ProfileMenuVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch Section.init(rawValue: indexPath.section)! {
        case Section.Content:
            let profile = profiles[indexPath.row]
            swithToProfile(profile)
        default:
            break
        }
    }
}

