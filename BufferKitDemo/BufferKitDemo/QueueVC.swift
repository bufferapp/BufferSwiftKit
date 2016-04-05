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
import FontAwesome_swift
import DZNEmptyDataSet

class QueueVC: UIViewController {

    weak var tableView: UITableView!

    var updatePage: UpdatePage!

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

        let button = UIButton(type: UIButtonType.Custom)
        let barsImage = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
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
            MainHUD.showMsg("Fetching profiles")
            BufferKitManager.sharedInstance.fetchProfiles()
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