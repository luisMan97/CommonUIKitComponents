//
//  AlertViewExampleViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 12/07/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class AlertViewExampleViewController: UIViewController {

    private let alertOptionsStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .vertical
    }

    private lazy var alertView = AlertView().then {
        $0.style = .success
        $0.titleText = "Title"
        $0.messageText = "Description"
        $0.titleTextColor = .blue
        $0.setupBorder(color: .gray)
    }

    private lazy var titleTextField = UITextField().then {
        $0.placeholder = "Title"
        $0.text = "Title"
        $0.borderStyle = .roundedRect
        $0.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        $0.delegate = self
    }

    private lazy var descriptionTextField = UITextField().then {
        $0.placeholder = "Description"
        $0.text = "Description"
        $0.borderStyle = .roundedRect
        $0.addTarget(self, action: #selector(descriptionTextFieldEditingDidChange), for: .editingChanged)
        $0.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
    }

    private func addSubViews() {
        view.addSubview(alertView)
        view.addSubview(alertOptionsStackView)
        alertOptionsStackView.addArrangedSubview(titleTextField)
        alertOptionsStackView.addArrangedSubview(descriptionTextField)
        addConstraints()
    }

    private func addConstraints() {
        alertView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         paddingLeft: 10,
                         right: view.rightAnchor,
                         paddingRight: 10)
        alertOptionsStackView.anchor(top: alertView.bottomAnchor,
                                     paddingTop: 10,
                                     left: view.leftAnchor,
                                     paddingLeft: 10,
                                     right: view.rightAnchor,
                                     paddingRight: 10)
    }

    @objc
    private func textFieldEditingDidChange(_ sender: Any) {
        alertView.titleText = titleTextField.text ?? ""
    }

    @objc
    private func descriptionTextFieldEditingDidChange(_ sender: Any) {
        alertView.messageText = descriptionTextField.text ?? ""
    }

}

// MARK: - UITextFieldDelegate
extension AlertViewExampleViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }

}
