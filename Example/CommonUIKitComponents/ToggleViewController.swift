//
//  ToggleViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ToggleViewController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var toggleView = ToggleView().then {
        $0.labelText = "Toggle view: Off"
        $0.switchCompletion = { [weak self] isOn in self?.toggleViewAction(isOn: isOn) }
    }

    private var toggleIsOn: Bool = false

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension ToggleViewController {
    func addSubviews() {
        view.addSubview(toggleView)
        addConstraints()
    }

    func addConstraints() {
        toggleView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingLeft: 8,
                          right: view.rightAnchor,
                          paddingRight: 8)
    }

    func toggleViewAction(isOn: Bool) {
        toggleIsOn = isOn
        toggleView.labelText = "Toggle view: \(isOn ? "On" : "Off")"
    }
}
