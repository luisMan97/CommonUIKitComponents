//
//  ButtonPadViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ButtonPadViewController: UIViewController {

    let buttonPadView = ButtonPadView().then {
        $0.primaryButtonText = "Primary button"
        $0.secondaryButtonText = "Secondary button"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }

}

// MARK: - Private Methods
private extension ButtonPadViewController {
    func addSubviews() {
        view.addSubview(buttonPadView)
        addConstraints()
    }

    func addConstraints() {
        buttonPadView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             left: view.leftAnchor,
                             paddingLeft: 8,
                             right: view.rightAnchor,
                             paddingRight: 8)
    }
}
