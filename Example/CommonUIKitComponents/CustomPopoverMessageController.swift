//
//  CustomPopoverMessageController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class CustomPopoverMessageController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var showButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) { [weak self] in self?.showPopover() }
        $0.setTitle("Show Popover", for: .normal)
        $0.underline()
        $0.setTitleColor(.blue, for: .normal)
        $0.isUserInteractionEnabled = true
    }

    private var popoverView: UIView?

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }

}

// MARK: - Private Methods
private extension CustomPopoverMessageController {
    func addSubviews() {
        view.addSubview(showButton)
        addConstraints()
    }

    func addConstraints() {
        showButton.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                          left: view.leftAnchor,
                          paddingLeft: 8,
                          right: view.rightAnchor,
                          paddingRight: 8)
    }

    func showPopover() {
        if popoverView != nil {
            popoverView?.removeFromSuperview()
            popoverView = nil
            return
        }
        popoverView = showButton.showCustomPopoverMessage("Popover Message",
                                                          size: .init(width: 208,
                                                                      height: 45))
    }
}

