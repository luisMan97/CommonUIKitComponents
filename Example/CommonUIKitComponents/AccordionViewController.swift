//
//  AccordionViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class AccordionViewController: UIViewController {

    // MARK: - Private UI Properties

    private var contentView = UIView().then {
        $0.backgroundColor = .gray
    }

    private lazy var accordionView = AccordionView().then {
        $0.headerTitle = "Accordion View"
        $0.addContentView(contentView)
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension AccordionViewController {
    func addSubviews() {
        view.addSubview(accordionView)
        addConstrints()
    }

    func addConstrints() {
        accordionView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                             left: view.leftAnchor,
                             paddingLeft: 8,
                             right: view.rightAnchor,
                             paddingRight: 8)

        contentView.anchor(height: 100)
    }
}
