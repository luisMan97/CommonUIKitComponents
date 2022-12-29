//
//  ModalViewController.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

class ModalViewController: UIViewController {
    
    // MARK: - Private UI Properties
    
    private var backgroundView = UIView()
    
    private var closeButtonImageView = UIImageView().then {
        $0.image = .xmark
        $0.tintColor = .darkGray
    }
    
    private lazy var closeButton = UIButton().then {
        $0.addTarget(self, action: #selector(cloaseAction), for: .touchUpInside)
    }

    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .white
    }
    
    private let scrollView = ScrollView().then {
        $0.addedScrollViewHeightIfNeeded = true
    }
    
    private let contentView = UIView()
    private lazy var buttonPadView = ButtonPadView().then {
        $0.backgroundColor = .clear
        $0.primaryCompletion = { [weak self] in self?.dismissWithEffect(completion: self?.primaryCompletion) }
        $0.secondaryCompletion = { [weak self] in self?.dismissWithEffect(completion: self?.secondaryCompletion) }
    }
    
    // MARK: - Internal Properties
    
    var containerStackViewBackgroundColor: UIColor? {
        didSet {
            containerStackView.backgroundColor = containerStackViewBackgroundColor
        }
    }
        
    // MARK: - Private Properties
    
    private var configuration = ModalConfiguration()
    
    // MARK: - Private Closure Properties
    
    private var primaryCompletion: CompletionHandler?
    private var secondaryCompletion: CompletionHandler?
    private var closeTapDismissViewCompletion: CompletionHandler?
    private var backgroundTapDismissViewCompletion: CompletionHandler?
    
    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupButtonPadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let customView = configuration.customView {
            customView.fixInView(contentView)
        }
        if configuration.backgroundTapDismissView {
            let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundViewAction))
            backgroundView.addGestureRecognizer(tap)
        }
    }
    
    // MARK: - Override Methods
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if configuration.roundOnlyTopCorners {
            containerStackView.roundTopCornersWith(cornerRadius: configuration.cornerRadius)
        } else {
            containerStackView.roundAllCornersWith(cornerRadius: configuration.cornerRadius)
        }
    }
    
    // MARK: - Internal Methods
    
    func config(_ configuration: ModalConfiguration,
                primaryCompletion: CompletionHandler? = nil,
                secondaryCompletion: CompletionHandler? = nil,
                closeTapDismissViewCompletion: CompletionHandler? = nil,
                backgroundTapDismissViewCompletion: CompletionHandler? = nil) {
        self.configuration = configuration
        self.primaryCompletion = primaryCompletion
        self.secondaryCompletion = secondaryCompletion
        self.closeTapDismissViewCompletion = closeTapDismissViewCompletion
        self.backgroundTapDismissViewCompletion = backgroundTapDismissViewCompletion
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        backgroundView.fixInView(view)
        view.addSubview(containerStackView)
        addCloseButton()
        containerStackView.addArrangedSubview(scrollView)
        addButtonPadView()
        scrollView.addContainerView(contentView)
        addConstraints()
    }
    
    private func addCloseButton() {
        guard configuration.showCloseButton else {
            return
        }
        view.addSubview(closeButtonImageView)
        view.addSubview(closeButton)
    }
    
    private func addButtonPadView() {
        if configuration.buttonsVerticalCenteredToBottom {
            view.addSubview(buttonPadView)
        } else {
            let buttonPadViewPaddingBottom = configuration.modalVeticalCentered ? configuration.buttonsPadBottomPadding : 0
            containerStackView.addArrangedSubview(buttonPadView, withMargin: .init(top: 0, left: 0, bottom: buttonPadViewPaddingBottom, right: 0))
        }
    }
    
    private func addConstraints() {
        addCloseButtonConstraints()
        addContainerStackViewConstraints()
        addButtonPadViewConstraints()
    }
    
    private func addCloseButtonConstraints() {
        guard configuration.showCloseButton else {
            return
        }
        closeButtonImageView.anchor(top: containerStackView.topAnchor,
                                    paddingTop: configuration.closeButtonPaddingTop,
                                    right: containerStackView.rightAnchor,
                                    paddingRight: configuration.closeButtonPaddingRight,
                                    width: configuration.closeButtonWidth,
                                    height: configuration.closeButtonHeight)
        
        closeButton.anchor(top: containerStackView.topAnchor,
                           right: containerStackView.rightAnchor,
                           width: 50,
                           height: 50)
    }
    
    private func addContainerStackViewConstraints() {
        addContainerStackViewVerticalConstraints()
        addContainerStackViewHorizontalConstraints()
    }
    
    private func addContainerStackViewVerticalConstraints() {
        if configuration.modalVeticalCentered {
            containerStackView.anchor(centerY: view)
        } else {
            containerStackView.anchor(topGreaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                      paddingTop: 20,
                                      bottom: view.bottomAnchor)
        }
    }
    
    private func addContainerStackViewHorizontalConstraints() {
        if let modalWidth = configuration.modalWidth,
           modalWidth < view.frame.width {
            let unwrapedModalMaxWidth = configuration.modalMaxWidth ?? 0
            let modalWidth = (configuration.modalMaxWidth != nil && modalWidth > unwrapedModalMaxWidth) ? unwrapedModalMaxWidth : modalWidth
            containerStackView.anchor(width: modalWidth,
                                      centerX: view)
            return
        }
        if let modalMaxWidth = configuration.modalMaxWidth,
           configuration.modalHorizontalPadding + modalMaxWidth < view.frame.width {
            containerStackView.anchor(width: modalMaxWidth,
                                      centerX: view)
            return
        }
        containerStackView.anchor(left: view.leftAnchor,
                                  paddingLeft: configuration.modalHorizontalPadding,
                                  right: view.rightAnchor,
                                  paddingRight: configuration.modalHorizontalPadding)
    }
    
    private func addButtonPadViewConstraints() {
        if configuration.buttonsVerticalCenteredToBottom {
            let viewToAlign: UIView = configuration.alignButtonsHorizontallyToModal ? containerStackView : view
            
            buttonPadView.anchor(left: viewToAlign.leftAnchor,
                                 paddingLeft: configuration.buttonsPadHorizontalPadding,
                                 right: viewToAlign.rightAnchor,
                                 paddingRight: configuration.buttonsPadHorizontalPadding,
                                 identifier: "buttonPadView")
            
            buttonPadView.setupConstraint(anchor: buttonPadView.centerYAnchor,
                                          equalTo: containerStackView.bottomAnchor,
                                          identifer: "buttonPadViewCenterY")
            return
        }
        if !configuration.modalVeticalCentered {
            buttonPadView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 paddingBottom: configuration.buttonsPadBottomPadding,
                                 identifier: "buttonPadView")
        }
        
        if configuration.alignButtonsHorizontallyToModal {
            buttonPadView.anchor(left: view.leftAnchor,
                                 paddingLeft: configuration.buttonsPadHorizontalPadding,
                                 right: view.rightAnchor,
                                 paddingRight: configuration.buttonsPadHorizontalPadding)
        }
    }
    
    private func setupButtonPadView() {
        let buttonsPadHorizontalPadding = configuration.buttonsVerticalCenteredToBottom || configuration.alignButtonsHorizontallyToModal ? 0 : configuration.buttonsPadHorizontalPadding
        buttonPadView.underlineButtonsWhenHasNoBackgroundColor = configuration.underlineButtonsWhenHasNoBackgroundColor
        buttonPadView.alignment = configuration.buttonPadAligment
        buttonPadView.buttonsSpacing = configuration.buttonsPadSpacing
        buttonPadView.buttonsHorizontalPadding = buttonsPadHorizontalPadding
        buttonPadView.setButtonsCornerRadius(configuration.buttonsPadCornerRadius)
        setupPrimaryButtonPadView()
        setupSecondaryButtonPadView()
        setAlertType()
        setButtonPadViewBottomConstriantIfNeeded()
    }
    
    private func setupPrimaryButtonPadView() {
        if let primaryButtonHeight = configuration.primaryButtonHeight {
            buttonPadView.primaryButtonHeight = primaryButtonHeight
        }
        buttonPadView.roundPrimaryButtonCornersWith(cornerRadius: configuration.primaryButtonCornerRadius,
                                                    borderColor: configuration.primaryButtonBorderColor,
                                                    borderWidth: configuration.primaryButtonBorderWidth)
        buttonPadView.primaryButtonText = configuration.primaryActionText
        buttonPadView.primaryButtonFont = configuration.primaryButtonFont
        if configuration.primaryButtonImage != nil {
            buttonPadView.setPrimaryImage(configuration.primaryButtonImage)
            if configuration.primaryActionText.isNotEmpty {
                buttonPadView.setPrimaryCenterTextAndImage(spacing: configuration.secondaryButtonImageSpacing)
            }
        }
        buttonPadView.primaryButtonColor = configuration.primaryButtonColor
        buttonPadView.primaryButtonTitleColor = configuration.primaryButtonTitleColor
    }
    
    private func setupSecondaryButtonPadView() {
        if configuration.secondaryActionText.isNotEmpty || configuration.secondaryButtonImage != nil {
            if configuration.secondaryActionText.isNotEmpty {
                buttonPadView.secondaryButtonText = configuration.secondaryActionText
                buttonPadView.secondaryButtonFont = configuration.secondaryButtonFont
                buttonPadView.secondaryButtonTitleColor = configuration.secondaryButtonTitleColor
            }
            if configuration.secondaryButtonImage != nil {
                buttonPadView.setSecondaryImage(configuration.secondaryButtonImage)
                if configuration.secondaryActionText.isNotEmpty {
                    buttonPadView.setSecondaryCenterTextAndImage(spacing: configuration.secondaryButtonImageSpacing)
                }
            }
            if let secondaryButtonHeight = configuration.secondaryButtonHeight {
                buttonPadView.secondaryButtonHeight = secondaryButtonHeight
            }
            buttonPadView.roundSecondaryButtonCornersWith(cornerRadius: configuration.secondaryButtonCornerRadius,
                                                          borderColor: configuration.secondaryButtonBorderColor,
                                                          borderWidth: configuration.secondaryButtonBorderWidth)
            
            buttonPadView.secondaryButtonColor = configuration.secondaryButtonColor
        } else {
            buttonPadView.secondaryButtonHidden = true
        }
    }
    
    private func setAlertType() {
        guard configuration.alertType != .custom else {
            return
        }
        if case .success = configuration.alertType {
            buttonPadView.primaryButtonColor = .systemGreen
        }
        if case .failure = configuration.alertType {
            buttonPadView.primaryButtonColor = .systemRed
        }
    }
    
    private func setButtonPadViewBottomConstriantIfNeeded() {
        guard view.windowHasNotSafeArea,
              configuration.buttonsPadHorizontalPadding > 0 else {
            return
        }
        if buttonPadView.secondaryButtonHidden {
            guard configuration.primaryButtonColor != .clear || configuration.primaryButtonColor != containerStackViewBackgroundColor else {
                return
            }
            if configuration.buttonsPadBottomPadding == 0 {
                view.updateConstraint(identifier: "buttonPadViewBottom", constant: -16)
            }
        } else {
            if configuration.buttonPadAligment == .vertical {
                guard configuration.secondaryButtonColor != .clear && configuration.secondaryButtonColor != containerStackViewBackgroundColor else {
                    return
                }
            }
            if configuration.buttonsPadBottomPadding == 0 {
                view.updateConstraint(identifier: "buttonPadViewBottom", constant: -16)
            }
        }
    }
    
    // MARK: - Private @objc Methods
    
    @objc
    private func backgroundViewAction() {
        dismissWithEffect(completion: backgroundTapDismissViewCompletion)
    }
    
    @objc
    private func cloaseAction() {
        dismissWithEffect(completion: closeTapDismissViewCompletion)
    }

}
