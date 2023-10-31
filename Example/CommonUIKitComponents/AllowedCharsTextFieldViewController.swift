//
//  AllowedCharsTextFieldViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class AllowedCharsTextFieldViewController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var allowedCharsTextField = AllowedCharsTextField().then {
        $0.allowedCharacters = .numbers
        $0.placeholder = "Allowed chars text field"
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension AllowedCharsTextFieldViewController {
    func addSubviews() {
        view.addSubview(allowedCharsTextField)
        addConstraints()
    }

    func addConstraints() {
        allowedCharsTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                     left: view.leftAnchor,
                                     paddingLeft: 8,
                                     right: view.rightAnchor,
                                     paddingRight: 8)
    }
}
