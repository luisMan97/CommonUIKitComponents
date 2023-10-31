//
//  StepperViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 30/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class StepperViewController: UIViewController {

    // MARK: - Private UI Properties

    private lazy var stepperView = StepperView().then {
        $0.labelText = "Stepper View: \(value)"
        $0.value = value
        $0.switchCompletion = { [weak self] value in self?.stepperViewAction(value: value) }
    }

    private var value: Double = .zero

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
}

// MARK: - Private Methods
private extension StepperViewController {
    func addSubviews() {
        view.addSubview(stepperView)
        addConstraints()
    }

    func addConstraints() {
        stepperView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           paddingLeft: 8,
                           right: view.rightAnchor,
                           paddingRight: 8)
    }

    private func stepperViewAction(value: Double) {
        self.value = value
        stepperView.labelText = "Stepper View: \(value)"
    }
}
