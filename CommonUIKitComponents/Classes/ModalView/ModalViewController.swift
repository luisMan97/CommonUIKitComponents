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
    
    private lazy var closeButton = UIButton().then {
        $0.addTarget(self, action: #selector(cloaseAction), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            $0.setImage(UIImage(systemName: "xmark"), for: .normal)
            $0.tintColor = .darkGray
        }
    }
    
    private let scrollView = ScrollView().then {
        $0.addedScrollViewHeightIfNeeded = true
    }

    private let containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .white
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
    private var backgroundTapDismissViewCompletion: CompletionHandler?
    
    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        buttonPadView.underlineButtonsWhenHasNoBackgroundColor = configuration.underlineButtonsWhenHasNoBackgroundColor
        buttonPadView.alignment = configuration.buttonPadAligment
        buttonPadView.buttonsSpacing = configuration.buttonsPadSpacing
        buttonPadView.setButtons(horizontalPadding: configuration.buttonsPadHorizontalPadding,
                                 cornerRadius: configuration.buttonsPadCornerRadius,
                                 primaryButtonCornerRadius: configuration.primaryButtonCornerRadius,
                                 secondaryButtonCornerRadius: configuration.secondaryButtonCornerRadius)
        buttonPadView.primaryButtonText = configuration.primaryActionText
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
        
        setButtonPadViewBottomConstriantIfNeeded()
    }
    
    func setButtonPadViewBottomConstriantIfNeeded() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let customView = configuration.customView {
            customView.fixInView(contentView)
        }
        if configuration.backgroundTapDismissView {
            let tap = UITapGestureRecognizer(target: self, action: #selector(cloaseAction))
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
                backgroundTapDismissViewCompletion: CompletionHandler? = nil) {
        self.configuration = configuration
        self.primaryCompletion = primaryCompletion
        self.secondaryCompletion = secondaryCompletion
        self.backgroundTapDismissViewCompletion = backgroundTapDismissViewCompletion
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        backgroundView.fixInView(view)
        view.addSubview(containerStackView)
        view.addSubview(closeButton)
         
        containerStackView.addArrangedSubview(scrollView)
        containerStackView.addArrangedSubview(buttonPadView)
         
        scrollView.addContainerView(contentView)
        addConstraints()
    }
    
    private func addConstraints() {
        // closeButton
        closeButton.anchor(top: containerStackView.topAnchor,
                           paddingTop:  configuration.closeButtonPaddingTop,
                           right: view.rightAnchor,
                           paddingRight: configuration.closeButtonPaddingRight,
                           width: configuration.closeButtonWidth,
                           height: configuration.closeButtonHeight)
        
        // containerStackView
        containerStackView.anchor(topGreaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor,
                                  paddingTop: 20,
                                  bottom: view.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor)
        
        // buttonPadView
        buttonPadView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             identifier: "buttonPadView")
    }
    
    // MARK: - Private @objc Methods
    
    @objc
    private func cloaseAction() {
        dismissWithEffect()
    }

}
