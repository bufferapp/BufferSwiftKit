//
//  QueueView.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import Stevia

class QueueView: UIView {

    let tableView = UITableView()

    convenience init() {
        self.init(frame:CGRectZero)
        render()
    }

    func render() {
        backgroundColor = .whiteColor()

        self.tableView.registerClass(QueueItemView.self, forCellReuseIdentifier: QueueItemView.CellIdentifier)

        sv(self.tableView)

        layout(
            0,
            |self.tableView|,
            0
        )

    }
}

