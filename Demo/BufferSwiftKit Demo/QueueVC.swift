//
//  ViewController.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 2/14/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import SteviaLayout
import ChameleonFramework
import DZNEmptyDataSet
import BufferSwiftKit

class QueueVC: UIViewController {

    weak var tableView: UITableView!

    var updatePage: UpdatePage!

    var tokenTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()

        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.setupView()
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QueueVC.handleUpdateRefresh(_:)), name: Notification.Update.UpdateSuccess, object: nil)

        if BufferKitManager.sharedInstance.isFetchingProfiles {
            MainHUD.showMsg("Fetching updates")
        }

    }

    func handleUpdateRefresh(notification: NSNotification) {
        updatePage = BufferKitManager.sharedInstance.pendingUpdatePage
        reloadData()
        self.navigationItem.title = BufferKitManager.sharedInstance.selectedProfile?.summary
        MainHUD.hide()
    }

    func setupView() {
        let queueView = QueueView()
        tableView = queueView.tableView
        tableView.delegate = self
        tableView.dataSource = self

        let button = UIButton(type: .Custom)
        let barsImage = UIImage(named: "bars")
        button.setImage(barsImage, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(QueueVC.selectProfileAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = CGRectMake(0, 0, 30, 30)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)

        self.view = queueView
    }


    func reloadData() {
        enableEmptyDataSet()
        tableView.reloadData()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if AuthManager.sharedManager.authenticated {
            self.fetchProfiles()
        } else {
            askForToken()
        }
    }

    func enableEmptyDataSet() {
        // Empty data set
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
        // A little trick for removing the cell separators
        tableView.tableFooterView = UIView()
    }

    // Fix for tableview under the navigationbar
    // http://stackoverflow.com/a/28879100/223228
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }

    func selectProfileAction(sender: UITabBarItem) {
        let profileMenuVC = ProfileMenuVC()
        presentViewController(UINavigationController(rootViewController: profileMenuVC), animated: true, completion: nil)
    }

    func fetchProfiles() {
        MainHUD.showMsg("Fetching profiles")
        BufferKitManager.sharedInstance.fetchProfiles()
    }

    func askForToken() {
        let alert = UIAlertController(title: "Buffer API token", message: "Please provide a valid Buffer API token", preferredStyle: .Alert)

        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Enter the API token"
            textField.keyboardType = .Default
            self.tokenTextField = textField
        }

        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (alertAction) in
            if let text = self.tokenTextField.text {
                if text.characters.count > 0 {
                    AuthManager.sharedManager.accessToken = text
                    self.fetchProfiles()
                } else {
                    self.showErrorMsg("Error", message: "The token length can't be 0", okHandler: { (alertAction) in
                        self.askForToken()
                    })
                }
            } else {
                self.showErrorMsg("Error", message: "No token provided", okHandler: { (alertAction) in
                    self.askForToken()
                })
            }
        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }
}


extension QueueVC: UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.updatePage?.updates?.count ?? 0
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(QueueItemView.CellIdentifier, forIndexPath: indexPath) as! QueueItemView

        let update = self.updatePage!.updates![indexPath.row]

        cell.configureWithUpdate(update)

        return cell
    }
}

extension QueueVC: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected: \(indexPath)")
    }
}

extension QueueVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "No updates in this queue"
        let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSForegroundColorAttributeName: UIColor.darkGrayColor()]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let attributes = [NSFontAttributeName: UIFont.boldSystemFontOfSize(16.0)]
        return NSAttributedString(string: "Reload", attributes: attributes)
    }

    func emptyDataSet(scrollView: UIScrollView!, didTapButton button: UIButton!) {
        MainHUD.showMsg("Reloading")
        BufferKitManager.sharedInstance.fetchPendingUpdatesSelectedProfile()
    }

}