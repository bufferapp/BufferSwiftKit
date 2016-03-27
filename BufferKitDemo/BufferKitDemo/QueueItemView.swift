//
//  QueueItemView.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/27/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import SteviaLayout
import ChameleonFramework

class QueueItemView: UITableViewCell {

    static let CellIdentifier = "QueueItemCellIdentifier"

    let updateText = UITextView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func render() {

        sv(updateText)

        layout(
            15,
            |-10-updateText-10-|,
            0
        )
    }

    func configureWithUpdate(update: Update) {
        if let text = update.text {
            let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(18.0), NSForegroundColorAttributeName: FlatGrayDark()]
            updateText.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }

    
    
}