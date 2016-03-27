//
//  LeftMenuVC.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/22/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import JGProgressHUD

class LeftMenuVC: UIViewController {

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

        navigationItem.title = "Queue"

        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.setupView()
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(profilesUpdated(_:)), name: Notification.Profile.UpdateSuccess, object: nil)

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(LeftMenuVC.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
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

    func profilesUpdated(notificaiton: NSNotification) {
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
        self.slideMenuController()?.closeLeft()
    }
}

extension LeftMenuVC: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.init(rawValue: section)! {
        case Section.Content:
            // Profile list
            return profiles?.count ?? 0
        case Section.Footer:
            // Logout
            return 1
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch Section.init(rawValue: indexPath.section)! {
        case Section.Content:
            return cellForContentOn(indexPath)
        case Section.Footer:
            return cellForFooterOn(indexPath)
        }
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
        case Section.Footer:
            return 20
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

    func cellForFooterOn(indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FooterCellIdentifier, forIndexPath: indexPath)
        if AuthManager.sharedManager.authenticated {
            cell.selectionStyle = .None
        } else {
            cell.selectionStyle = .Default
        }

        cell.textLabel?.text = "Logout"
        return cell
    }


}

extension LeftMenuVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch Section.init(rawValue: indexPath.section)! {
        case Section.Content:
            let profile = profiles[indexPath.row]
            swithToProfile(profile)
        case Section.Footer:
            logoutAction()
        }
    }
}

// actions
extension LeftMenuVC {
    func logoutAction() {
        MainHUD.showMsg("Logging out")

        self.slideMenuController()?.closeLeft()
        
        // Present HUD
        BufferKitManager.sharedInstance.logout() { (success, error) in
            if success {
                self.wipeAuthAndNotify()
                MainHUD.hide()
            } else {
                MainHUD.hide()
                // Present message
                self.showErrorMsg("Failed to logout", message: "Error: \(error!)") { (alert) in
                    self.wipeAuthAndNotify()
                }
            }
        }
    }

    func wipeAuthAndNotify() {
        AuthManager.sharedManager.logout()
        BufferKitManager.sharedInstance.reset()
        NSNotificationCenter.defaultCenter().postNotificationName(Notification.Auth.SuccessfulLogout, object: nil)
    }
}
