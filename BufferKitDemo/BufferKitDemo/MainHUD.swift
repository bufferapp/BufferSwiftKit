//
//  MainHUD.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import JGProgressHUD

class MainHUD {

    let HUD = JGProgressHUD(style: .Dark)
    static let sharedInstance = MainHUD()

    var view: UIView!

    private init() {

    }

    class func setup(view: UIView) {
        sharedInstance.view = view
    }


    class func showMsg(msg: String) {
        sharedInstance.HUD.textLabel.text = msg
        sharedInstance.HUD.showInView(sharedInstance.view)
    }

    class func hide() {
        sharedInstance.HUD.dismiss()
    }



    
}