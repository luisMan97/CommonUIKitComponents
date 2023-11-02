//
//  ScrollViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ScrollViewController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var scrollView = ScrollView().then {
        $0.addContainerView(containerStackView)
    }

    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 800
    }

    private let topLabel = UILabel().then {
        $0.text = "Top Label - scroll to bottom"
    }

    private let bottomLabel = UILabel().then {
        $0.text = "Bottom Label"
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension ScrollViewController {
    func addSubviews() {
        scrollView.fixInView(view)
        containerStackView.addArrangedSubview(topLabel)
        containerStackView.addArrangedSubview(bottomLabel)
    }
}
