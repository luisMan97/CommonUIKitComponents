//
//  ModalExampleViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ModalExampleViewController: UIViewController {
    
    // MARK: - Private UI Properties
    
    private let scrollView = ScrollView()
    
    private let alertOptionsStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .vertical
    }
    
    private lazy var simpleModalWithAlertViewButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) { [weak self] in
            self?.showModal()
        }
        $0.setTitle("Modal with custom Alert View", for: .normal)
        $0.underline()
        $0.setTitleColor(.blue, for: .normal)
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var secondaryActionTextField = UITextField().then {
        $0.placeholder = "Secondary action text"
        $0.text = secondaryActionText
        $0.borderStyle = .roundedRect
        $0.addTarget(self, action: #selector(textFieldEditingDidChange), for: .editingChanged)
        $0.delegate = self
    }
    
    private lazy var cornerRadiusView = StepperView().then {
        $0.labelText = "Corner radius: \(cornerRadius)"
        $0.value = cornerRadius
        $0.switchCompletion = { [weak self] value in self?.cornerRadiusViewAction(value: value) }
    }
    
    private lazy var buttonModalVerticalCentered = ToggleView().then {
        $0.labelText = "Modal Vertical Centered"
        $0.switchCompletion = { [weak self] isOn in
            self?.modalVerticalCentered = isOn
        }
    }
    
    private lazy var buttonCenterVerticalToBottom = ToggleView().then {
        $0.labelText = "Buttons Vertical Centered To Bottom"
        $0.switchCompletion = { [weak self] isOn in
            self?.centerButtonsVerticalToBottom = isOn
        }
    }
    
    private lazy var buttonAligmntVertical = ToggleView().then {
        $0.labelText = "Vertical Buttons"
        $0.switchCompletion = { [weak self] isOn in
            self?.buttonAligment = isOn ? .vertical : .horizontal
        }
    }
    
    private lazy var underlineButtonsWhenHasNoBackgroundColorView = ToggleView().then {
        $0.labelText = "Underline buttons when has no background color"
        $0.switchCompletion = { [weak self] isOn in
            self?.underlineButtonsWhenHasNoBackgroundColor = isOn
            if isOn {
                self?.secondaryButtonClearColor.isOn = true
            }
        }
    }
    
    private lazy var secondaryButtonClearColor = ToggleView().then {
        $0.labelText = "Secondary button clear color"
        $0.switchCompletion = { [weak self] isOn in
            self?.secondaryButtonClearColorAction(isOn: isOn)
        }
    }
    
    private lazy var buttonsPadSpacingView = StepperView().then {
        $0.labelText = "ButtonsPad spacing: \(buttonsPadSpacing) (when primary or secondary buttons have corner radius, this spacing is 8)"
        $0.value = buttonsPadSpacing
        $0.switchCompletion = { [weak self] value in self?.buttonsPadSpacingViewAction(value: value) }
    }
    
    private lazy var buttonPadCornerRadiusView = StepperView().then {
        $0.labelText = "Buttons pad CornerRadius: \(buttonsPadCornerRadius)"
        $0.value = buttonsPadCornerRadius
        $0.switchCompletion = { [weak self] value in self?.buttonPadCornerRadiusViewAction(value: value) }
    }
    
    private lazy var primaryButtonCornerRadiusView = StepperView().then {
        $0.labelText = "Primary Button CornerRadius: \(primaryButtonCornerRadius)"
        $0.value = primaryButtonCornerRadius
        $0.switchCompletion = { [weak self] value in self?.primaryButtonCornerRadiusViewAction(value: value) }
    }
    
    private lazy var secondaryButtonCornerRadiusView = StepperView().then {
        $0.labelText = "Secondary Button CornerRadius: \(secondaryButtonCornerRadius)"
        $0.value = secondaryButtonCornerRadius
        $0.switchCompletion = { [weak self] value in self?.secondaryButtonCornerRadiusViewAction(value: value) }
    }
    
    // MARK: - Private Properties
    
    private var secondaryActionText = "Cancelar"
    private var cornerRadius: CGFloat = 8
    private var buttonAligment = ButtonPadAlign.horizontal
    private var modalVerticalCentered = false
    private var centerButtonsVerticalToBottom = false
    private var secondaryButtonColor = UIColor.red
    private var underlineButtonsWhenHasNoBackgroundColor = false
    private var buttonsPadSpacing: Double = 0
    private var buttonsPadCornerRadius: Double = 8
    private var primaryButtonCornerRadius: Double = 8
    private var secondaryButtonCornerRadius: Double = 8
    
    // MARK: - UIViewController Lyfecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        scrollView.fixInView(view)
        scrollView.addContainerView(alertOptionsStackView)
        
        alertOptionsStackView.addArrangedSubview(simpleModalWithAlertViewButton)
        alertOptionsStackView.addArrangedSubview(secondaryActionTextField)
        alertOptionsStackView.addArrangedSubview(cornerRadiusView)
        alertOptionsStackView.addArrangedSubview(buttonAligmntVertical)
        alertOptionsStackView.addArrangedSubview(buttonModalVerticalCentered)
        alertOptionsStackView.addArrangedSubview(buttonCenterVerticalToBottom)
        alertOptionsStackView.addArrangedSubview(buttonAligmntVertical)
        alertOptionsStackView.addArrangedSubview(underlineButtonsWhenHasNoBackgroundColorView)
        alertOptionsStackView.addArrangedSubview(secondaryButtonClearColor)
        alertOptionsStackView.addArrangedSubview(buttonsPadSpacingView)
        alertOptionsStackView.addArrangedSubview(primaryButtonCornerRadiusView)
        alertOptionsStackView.addArrangedSubview(secondaryButtonCornerRadiusView)
        alertOptionsStackView.addArrangedSubview(buttonPadCornerRadiusView)
        
        addConstraints()
    }
    
    private func addConstraints() {
        alertOptionsStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                     bottomLessThanOrEqualTo: view.bottomAnchor,
                                     paddingBottom: 18,
                                     left: view.leftAnchor,
                                     paddingLeft: 8,
                                     right: view.rightAnchor,
                                     paddingRight: 8)
        
        simpleModalWithAlertViewButton.anchor(height: 45)
    }
    
    private func showModal() {
        let modalConfiguration = ModalConfiguration()
            .setCornerRadius(cornerRadius)
            .setRoundOnlyTopCorners(true)
            .setCustomView(buildAlertView())
            .setPrimaryButtonCornerRadius(primaryButtonCornerRadius)
            .setSecondaryActionText(secondaryActionText)
            .setSecondaryButtonColor(secondaryButtonColor)
            .setSecondaryButtonTitleColor(.white)
            .setSecondaryButtonCornerRadius(secondaryButtonCornerRadius)
            .setButtonPadAligment(buttonAligment)
            .setButtonsPadSpacing(buttonsPadSpacing)
            .setButtonsPadCornerRadius(buttonsPadCornerRadius)
            .setUnderlineButtonsWhenHasNoBackgroundColor(underlineButtonsWhenHasNoBackgroundColor)
            .setModalVeticalCentered(modalVerticalCentered)
            .setButtonsVerticalCenteredToBottom(centerButtonsVerticalToBottom)
        
        showModal(modalConfiguration, primaryCompletion: {
            print("Primary button tapped")
        })
    }
    
    private func buildAlertView() -> AlertView {
        let alertView = AlertView().then {
            $0.alertType = .success
            $0.titleText = "title"
            $0.messageText = "description"
            $0.titleTextColor = .blue
        }
        return alertView
    }
    
    private func secondaryButtonClearColorAction(isOn: Bool) {
        secondaryButtonColor = isOn ? .clear : .red
        if !isOn {
            underlineButtonsWhenHasNoBackgroundColorView.isOn = false
        }
    }
    
    private func buttonsPadSpacingViewAction(value: Double) {
        buttonsPadSpacing = value
        if value == 0 {
            buttonsPadSpacingView.labelText = "ButtonsPad spacing: \(buttonsPadSpacing) (when primary or secondary buttons have corner radius, this spacing is 8)"
        } else {
            buttonsPadSpacingView.labelText = "ButtonsPad spacing: \(value)"
        }
    }
    
    private func cornerRadiusViewAction(value: Double) {
        cornerRadius = value
        cornerRadiusView.labelText = "Corner radius: \(value)"
    }
    
    private func buttonPadCornerRadiusViewAction(value: Double) {
        buttonsPadCornerRadius = value
        buttonPadCornerRadiusView.labelText = "Buttons pad corner radius: \(value)"
    }
    
    private func primaryButtonCornerRadiusViewAction(value: Double) {
        primaryButtonCornerRadius = value
        primaryButtonCornerRadiusView.labelText = "Primary button corner radius: \(value)"
    }
    
    private func secondaryButtonCornerRadiusViewAction(value: Double) {
        secondaryButtonCornerRadius = value
        secondaryButtonCornerRadiusView.labelText = "Secondary button corner radius: \(value)"
    }
    
    @objc
    private func textFieldEditingDidChange(_ sender: Any) {
        secondaryActionText = secondaryActionTextField.text ?? ""
    }
    
}

extension ModalExampleViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
       return true
    }
    
}
