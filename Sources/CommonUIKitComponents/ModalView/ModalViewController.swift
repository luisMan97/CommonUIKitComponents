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
        view.addSubview(closeButtonImageView)
        view.addSubview(closeButton)
         
        containerStackView.addArrangedSubview(scrollView)
        if configuration.buttonsVerticalCenteredToBottom {
            view.addSubview(buttonPadView)
        } else {
            let buttonPadViewPaddingBottom = configuration.modalVeticalCentered ? configuration.buttonsPadBottomPadding : 0
            containerStackView.addArrangedSubview(buttonPadView, withMargin: .init(top: 0, left: 0, bottom: buttonPadViewPaddingBottom, right: 0))
        }
         
        scrollView.addContainerView(contentView)
        addConstraints()
    }
    
    private func addConstraints() {
        // closeButton
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
        
        // containerStackView
        let containerStackViewBottom = configuration.modalVeticalCentered ? nil : view.bottomAnchor
        let containerStackViewCenterY = configuration.modalVeticalCentered ? view : nil
         
        containerStackView.anchor(topGreaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                  paddingTop: 20,
                                  bottom: containerStackViewBottom,
                                  left: view.leftAnchor,
                                  paddingLeft: configuration.modalHorizontalPadding,
                                  right: view.rightAnchor,
                                  paddingRight: configuration.modalHorizontalPadding,
                                  centerY: containerStackViewCenterY)
        
        // buttonPadView
        let buttonPadViewBottom = (configuration.buttonsVerticalCenteredToBottom || configuration.modalVeticalCentered) ? nil : view.safeAreaLayoutGuide.bottomAnchor
        let buttonPadViewPaddingBottom = (configuration.buttonsVerticalCenteredToBottom || configuration.modalVeticalCentered) ? 0 : configuration.buttonsPadBottomPadding
        let buttonPadViewLeft = configuration.buttonsVerticalCenteredToBottom ? view.leftAnchor : nil
        let buttonPadViewRight = configuration.buttonsVerticalCenteredToBottom ? view.rightAnchor : nil
        let buttonPadViewPaddingLeft = configuration.buttonsVerticalCenteredToBottom ? configuration.buttonsPadHorizontalPadding : 0
        let buttonPadViewPaddingRight = configuration.buttonsVerticalCenteredToBottom ? configuration.buttonsPadHorizontalPadding : 0
        let buttonPadViewPaddingCenterX = configuration.buttonsVerticalCenteredToBottom ? view : nil
    
        buttonPadView.anchor(bottom: buttonPadViewBottom,
                             paddingBottom: buttonPadViewPaddingBottom,
                             left: buttonPadViewLeft,
                             paddingLeft: buttonPadViewPaddingLeft,
                             right: buttonPadViewRight,
                             paddingRight: buttonPadViewPaddingRight,
                             centerX: buttonPadViewPaddingCenterX,
                             identifier: "buttonPadView")
        
        if configuration.buttonsVerticalCenteredToBottom {
            let anchor = buttonPadView.centerYAnchor.constraint(equalTo: containerStackView.bottomAnchor)
            anchor.identifier = "buttonPadViewCenterY"
            anchor.isActive = true
        }
    }
    
    private func setupButtonPadView() {
        buttonPadView.underlineButtonsWhenHasNoBackgroundColor = configuration.underlineButtonsWhenHasNoBackgroundColor
        buttonPadView.alignment = configuration.buttonPadAligment
        buttonPadView.buttonsSpacing = configuration.buttonsPadSpacing
        if let primaryButtonHeight = configuration.primaryButtonHeight { buttonPadView.primaryButtonHeight = primaryButtonHeight }
        if let secondaryButtonHeight = configuration.secondaryButtonHeight { buttonPadView.secondaryButtonHeight = secondaryButtonHeight }
        buttonPadView.setButtons(horizontalPadding: configuration.buttonsPadHorizontalPadding,
                                 cornerRadius: configuration.buttonsPadCornerRadius,
                                 primaryButtonCornerRadius: configuration.primaryButtonCornerRadius,
                                 primaryBorderColor: configuration.primaryButtonBorderColor,
                                 primaryBorderWith: configuration.primaryButtonBorderWidth,
                                 secondaryButtonCornerRadius: configuration.secondaryButtonCornerRadius,
                                 secondaryBorderColor: configuration.secondaryButtonBorderColor,
                                 secondaryBorderWith: configuration.secondaryButtonBorderWidth)
        buttonPadView.primaryButtonText = configuration.primaryActionText
        buttonPadView.setPrimaryImage(configuration.primaryButtonImage,
                                      spacing: configuration.primaryButtonImageSpacing)
        buttonPadView.primaryButtonColor = configuration.primaryButtonColor
        buttonPadView.primaryButtonTitleColor = configuration.primaryButtonTitleColor
        if let secondaryTitle = configuration.secondaryActionText,
           secondaryTitle.isNotEmpty {
            buttonPadView.secondaryButtonText = secondaryTitle
            buttonPadView.secondaryButtonColor = configuration.secondaryButtonColor
            buttonPadView.secondaryButtonTitleColor = configuration.secondaryButtonTitleColor
        } else {
            buttonPadView.secondaryButtonHidden = true
        }
        if configuration.secondaryButtonImage != nil {
            buttonPadView.secondaryButtonHidden = false
            buttonPadView.setSecondaryImage(configuration.secondaryButtonImage,
                                            spacing: configuration.secondaryButtonImageSpacing)
        }
        setAlertType()
        setButtonPadViewBottomConstriantIfNeeded()
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
