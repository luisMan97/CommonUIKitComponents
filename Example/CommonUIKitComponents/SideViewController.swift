//
//  SideViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class SideViewController: UIViewController {

    // MARK: - Private UI Properties

    private var contentView = UIView().then {
        $0.backgroundColor = .white
    }

    private lazy var sideView = SideView().then {
        $0.didEndClose.observe { [weak self] in
            if let sideViewRightConstraint = self?.view.constraintWith(identifier: "sideViewRight") {
                sideViewRightConstraint.constant = -UIScreen.main.bounds.width
            }
        }
        $0.addContentView(contentView)
    }

    private lazy var showButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) { [weak self] in self?.showSideView() }
        $0.setTitle("Show Side View", for: .normal)
        $0.underline()
        $0.setTitleColor(.blue, for: .normal)
        $0.isUserInteractionEnabled = true
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension SideViewController {
    func addSubviews() {
        view.addSubview(showButton)
        view.addSubview(sideView)
        addConstraints()
    }

    func addConstraints() {
        sideView.anchor(top: view.topAnchor,
                        bottom: view.bottomAnchor,
                        left: view.leftAnchor,
                        right: view.rightAnchor,
                        paddingRight: UIScreen.main.bounds.width,
                        identifier: "sideView")

        showButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingLeft: 8,
                          right: view.rightAnchor,
                          paddingRight: 8)
    }

    private func showSideView() {
        if let sideViewRightConstraint = view.constraintWith(identifier: "sideViewRight") {
            sideViewRightConstraint.constant = .zero
        }
        view.layoutIfNeeded()
        sideView.showWithEffect()
    }
}
