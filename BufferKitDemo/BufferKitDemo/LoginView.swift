//
//  LoginView.swift
//  BufferKitDemo
//
//  Created by Humberto Aquino on 3/13/16.
//  Copyright © 2016 Buffer. All rights reserved.
//

import UIKit
import SteviaLayout
import ChameleonFramework

protocol LoginViewDelegate {
    func signInButtonTapped()
}

class LoginView: UIView {

    var delegate: LoginViewDelegate?

    let authLabel = UILabel()
    let signInButton = UIButton()

    convenience init() {
        self.init(frame:CGRectZero)
        render()
    }

    func render() {
        backgroundColor = FlatWhite()

        sv(
            authLabel.text("Authenticate").style(titleStyle),
            signInButton.text("Sign in").style(signInStyle).tap(signInButtonTapped)
        )

        layout(
            20,
            |-authLabel-| ~ 100,
            |-signInButton-| ~ 60,
            "",
            0
        )
    }

    func titleStyle(l:UILabel) {
        l.textAlignment = .Center
        l.font = UIFont(name: l.font.fontName, size: 26.0)
    }

    func signInStyle(b:UIButton) {
        b.backgroundColor = FlatSkyBlue()
    }

    func signInButtonTapped() {
        delegate?.signInButtonTapped()
    }

}