//
//  UIUtilsExtensions.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit

extension UIViewController {

    func showErrorMsg(title: String, message: String, okHandler:((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: okHandler))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension UIViewController {

    func setNavigationBarItem() {
        let barsImage = UIImage.fontAwesomeIconWithName(.Bars, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        self.addLeftBarButtonWithImage(barsImage)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
    }

    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
}