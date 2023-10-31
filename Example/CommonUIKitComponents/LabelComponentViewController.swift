//
//  LabelComponentViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class LabelComponentViewController: UIViewController {

    private let containerStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .vertical
    }

    private lazy var labelComponent = LabelComponentView().then {
        $0.text = "Label component"
        $0.textColor = .white
        $0.pillBackgroundColor = .orange
        $0.updateTextMarginConstraints(insets: textInsets)
    }

    private lazy var labelComponentWithImage = LabelComponentView().then {
        $0.text = "Label component"
        $0.textColor = .white
        $0.pillBackgroundColor = .orange
        $0.updateTextMarginConstraints(insets: textInsets)
        if #available(iOS 13.0, *) {
            $0.image = .init(systemName: "pencil.circle.fill")
        } else {
            // Fallback on earlier versions
        }
    }

    private lazy var labelComponentWithRightImage = LabelComponentView().then {
        $0.text = "Label component"
        $0.textColor = .white
        $0.pillBackgroundColor = .orange
        $0.updateTextMarginConstraints(insets: textInsets)
        $0.imagePlacement = .trailing
        if #available(iOS 13.0, *) {
            $0.image = .init(systemName: "pencil.circle.fill")
        } else {
            // Fallback on earlier versions
        }
    }

    private var componentInsets: UIEdgeInsets { .init(top: 16,
                                                      left: .zero,
                                                      bottom: .zero,
                                                      right: .zero) }
    private var textInsets: UIEdgeInsets { .init(top: 3,
                                                 left: 4,
                                                 bottom: 3,
                                                 right: 4) }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }

}

// MARK: - Private Methods
private extension LabelComponentViewController {
    func addSubviews() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(labelComponent)
        containerStackView.addArrangedSubview(labelComponentWithImage)
        containerStackView.addArrangedSubview(labelComponentWithRightImage)
        addConstraints()
    }

    func addConstraints() {
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.leftAnchor,
                                  paddingLeft: 8,
                                  right: view.rightAnchor,
                                  paddingRight: 8)
    }
}
