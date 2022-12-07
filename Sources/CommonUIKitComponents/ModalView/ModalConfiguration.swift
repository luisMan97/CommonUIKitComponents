//
//  ModalBuilder.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

public class ModalConfiguration {
    
    // MARK: - Internal private(set) Properties
    
    private(set) var alertType: AlertType
    private(set) var cornerRadius: CGFloat
    private(set) var roundOnlyTopCorners: Bool
    private(set) var customView: UIView?
    private(set) var modalHorizontalPadding: CGFloat
    private(set) var modalVeticalCentered: Bool
    private(set) var primaryActionText: String
    private(set) var secondaryActionText: String?
    private(set) var primaryButtonFont: UIFont?
    private(set) var secondaryButtonFont: UIFont?
    private(set) var primaryButtonImage: UIImage?
    private(set) var primaryButtonImageSpacing: CGFloat
    private(set) var secondaryButtonImage: UIImage?
    private(set) var secondaryButtonImageSpacing: CGFloat
    private(set) var showButtons: Bool
    private(set) var buttonsVerticalCenteredToBottom: Bool
    private(set) var primaryButtonColor: UIColor?
    private(set) var secondaryButtonColor: UIColor?
    private(set) var primaryButtonTitleColor: UIColor?
    private(set) var secondaryButtonTitleColor: UIColor?
    private(set) var primaryButtonHeight: CGFloat?
    private(set) var secondaryButtonHeight: CGFloat?
    private(set) var primaryButtonCornerRadius: CGFloat
    private(set) var secondaryButtonCornerRadius: CGFloat
    private(set) var primaryButtonBorderWidth: CGFloat?
    private(set) var secondaryButtonBorderWidth: CGFloat?
    private(set) var primaryButtonBorderColor: UIColor?
    private(set) var secondaryButtonBorderColor: UIColor?
    private(set) var buttonPadAligment: ButtonPadAlign
    private(set) var backgroundTapDismissView: Bool
    private(set) var closeButtonPaddingTop: CGFloat
    private(set) var closeButtonPaddingRight: CGFloat
    private(set) var closeButtonHeight: CGFloat
    private(set) var closeButtonWidth: CGFloat
    private(set) var showCloseButton: Bool
    private(set) var buttonsPadSpacing: CGFloat
    private(set) var buttonsPadHorizontalPadding: CGFloat
    private(set) var buttonsPadBottomPadding: CGFloat
    private(set) var buttonsPadCornerRadius: CGFloat
    private(set) var underlineButtonsWhenHasNoBackgroundColor: Bool
    
    // MARK: - Initializers
    
    public init(alertType: AlertType = .custom,
                cornerRadius: CGFloat = 8,
                roundOnlyTopCorners: Bool = false,
                customView: UIView? = nil,
                modalHorizontalPadding: CGFloat = 0,
                modalVeticalCentered: Bool = false,
                primaryActionText: String = "Aceptar",
                primaryButtonFont: UIFont? = nil,
                primaryButtonImage: UIImage? = nil,
                primaryButtonImageSpacing: CGFloat = 8,
                primaryButtonColor: UIColor? = .blue,
                primaryButtonTitleColor: UIColor? = nil,
                primaryButtonHeight: CGFloat? = nil,
                primaryButtonCornerRadius: CGFloat = 8,
                primaryButtonBorderWidth: CGFloat? = nil,
                primaryButtonBorderColor: UIColor? = nil,
                secondaryActionText: String? = nil,
                secondaryButtonFont: UIFont? = nil,
                secondaryButtonImage: UIImage? = nil,
                secondaryButtonImageSpacing: CGFloat = 8,
                secondaryButtonColor: UIColor? = .lightGray.withAlphaComponent(0.3),
                secondaryButtonTitleColor: UIColor? = .black,
                secondaryButtonHeight: CGFloat? = nil,
                secondaryButtonCornerRadius: CGFloat = 8,
                secondaryButtonBorderWidth: CGFloat? = nil,
                secondaryButtonBorderColor: UIColor? = nil,
                showButtons: Bool = true,
                buttonsVerticalCenteredToBottom: Bool = false,
                buttonPadAligment: ButtonPadAlign = .horizontal,
                buttonsPadSpacing: CGFloat = 0,
                buttonsPadHorizontalPadding: CGFloat = 34,
                buttonsPadBottomPadding: CGFloat = 0,
                buttonsPadCornerRadius: CGFloat = 8,
                backgroundTapDismissView: Bool = false,
                closeButtonPaddingTop: CGFloat = 16,
                closeButtonPaddingRight: CGFloat = 16,
                closeButtonHeight: CGFloat = 20,
                closeButtonWidth: CGFloat = 20,
                showCloseButton: Bool = true,
                underlineButtonsWhenHasNoBackgroundColor: Bool = false) {
        self.alertType = alertType
        self.cornerRadius = cornerRadius
        self.roundOnlyTopCorners = roundOnlyTopCorners
        self.customView = customView
        self.modalHorizontalPadding = modalHorizontalPadding
        self.modalVeticalCentered = modalVeticalCentered
        self.primaryActionText = primaryActionText
        self.primaryButtonFont = primaryButtonFont
        self.primaryButtonImage = primaryButtonImage
        self.primaryButtonImageSpacing = primaryButtonImageSpacing
        self.primaryButtonColor = primaryButtonColor
        self.primaryButtonTitleColor = primaryButtonTitleColor
        self.primaryButtonCornerRadius = primaryButtonCornerRadius
        self.primaryButtonBorderWidth = primaryButtonBorderWidth
        self.primaryButtonBorderColor = primaryButtonBorderColor
        self.secondaryActionText = secondaryActionText
        self.secondaryButtonFont = secondaryButtonFont
        self.secondaryButtonImage = secondaryButtonImage
        self.secondaryButtonImageSpacing = secondaryButtonImageSpacing
        self.secondaryButtonColor = secondaryButtonColor
        self.secondaryButtonTitleColor = secondaryButtonTitleColor
        self.primaryButtonHeight = primaryButtonHeight
        self.secondaryButtonHeight = secondaryButtonHeight
        self.secondaryButtonCornerRadius = secondaryButtonCornerRadius
        self.secondaryButtonBorderWidth = primaryButtonBorderWidth
        self.secondaryButtonBorderColor = primaryButtonBorderColor
        self.showButtons = showButtons
        self.buttonsVerticalCenteredToBottom = buttonsVerticalCenteredToBottom
        self.buttonPadAligment = buttonPadAligment
        self.buttonsPadSpacing = buttonsPadSpacing
        self.buttonsPadHorizontalPadding = buttonsPadHorizontalPadding
        self.buttonsPadBottomPadding = buttonsPadBottomPadding
        self.backgroundTapDismissView = backgroundTapDismissView
        self.closeButtonPaddingTop = closeButtonPaddingTop
        self.closeButtonPaddingRight = closeButtonPaddingRight
        self.closeButtonHeight = closeButtonHeight
        self.closeButtonWidth = closeButtonWidth
        self.showCloseButton = showCloseButton
        self.buttonsPadCornerRadius = buttonsPadCornerRadius
        self.underlineButtonsWhenHasNoBackgroundColor = underlineButtonsWhenHasNoBackgroundColor
    }
    
    public func setAlertType(_ alertType: AlertType) -> ModalConfiguration {
        self.alertType = alertType
        return self
    }
    
    public func setCornerRadius(_ cornerRadius: CGFloat) -> ModalConfiguration {
        self.cornerRadius = cornerRadius
        return self
    }
    
    public func setRoundOnlyTopCorners(_ roundOnlyTopCorners: Bool) -> ModalConfiguration {
        self.roundOnlyTopCorners = roundOnlyTopCorners
        return self
    }
    
    public func setCustomView(_ customView: UIView) -> ModalConfiguration {
        self.customView = customView
        return self
    }
    
    public func setModalHorizontalPadding(_ modalHorizontalPadding: CGFloat) -> ModalConfiguration {
        self.modalHorizontalPadding = modalHorizontalPadding
        return self
    }
    
    public func setModalVeticalCentered(_ modalVeticalCentered: Bool) -> ModalConfiguration {
        self.modalVeticalCentered = modalVeticalCentered
        return self
    }
    
    public func setPrimaryActionText(_ primaryActionText: String) -> ModalConfiguration {
        self.primaryActionText = primaryActionText
        return self
    }
    
    public func setPrimaryButtonFont(_ primaryButtonFont: UIFont) -> ModalConfiguration {
        self.primaryButtonFont = primaryButtonFont
        return self
    }
    
    public func setPrimaryButtonImage(_ primaryButtonImage: UIImage?) -> ModalConfiguration {
        self.primaryButtonImage = primaryButtonImage
        return self
    }
    
    public func setPrimaryButtonImageSpacing(_ primaryButtonImageSpacing: CGFloat) -> ModalConfiguration {
        self.primaryButtonImageSpacing = primaryButtonImageSpacing
        return self
    }
    
    public func setPrimaryButtonColor(_ primaryButtonColor: UIColor) -> ModalConfiguration {
        self.primaryButtonColor = primaryButtonColor
        return self
    }
    
    public func setPrimaryButtonTitleColor(_ primaryButtonTitleColor: UIColor) -> ModalConfiguration {
        self.primaryButtonTitleColor = primaryButtonTitleColor
        return self
    }
    
    public func setPrimaryButtonHeight(_ primaryButtonHeight: CGFloat) -> ModalConfiguration {
        self.primaryButtonHeight = primaryButtonHeight
        return self
    }
    
    public func setPrimaryButtonCornerRadius(_ primaryButtonCornerRadius: CGFloat) -> ModalConfiguration {
        self.primaryButtonCornerRadius = primaryButtonCornerRadius
        return self
    }
    
    public func setPrimaryButtonBorderWidth(_ primaryButtonBorderWidth: CGFloat) -> ModalConfiguration {
        self.primaryButtonBorderWidth = primaryButtonBorderWidth
        return self
    }
    
    public func setPrimaryButtonBorderColor(_ primaryButtonBorderColor: UIColor) -> ModalConfiguration {
        self.primaryButtonBorderColor = primaryButtonBorderColor
        return self
    }
    
    public func setSecondaryActionText(_ secondaryActionText: String) -> ModalConfiguration {
        self.secondaryActionText = secondaryActionText
        return self
    }
    
    public func setSecondaryButtonFont(_ secondaryButtonFont: UIFont) -> ModalConfiguration {
        self.secondaryButtonFont = secondaryButtonFont
        return self
    }
    
    public func setSecondaryButtonImage(_ secondaryButtonImage: UIImage?) -> ModalConfiguration {
        self.secondaryButtonImage = secondaryButtonImage
        return self
    }
    
    public func setSecondaryButtonImageSpacing(_ secondaryButtonImageSpacing: CGFloat) -> ModalConfiguration {
        self.secondaryButtonImageSpacing = secondaryButtonImageSpacing
        return self
    }
    
    public func setSecondaryButtonColor(_ secondaryButtonColor: UIColor) -> ModalConfiguration {
        self.secondaryButtonColor = secondaryButtonColor
        return self
    }
    
    public func setSecondaryButtonTitleColor(_ secondaryButtonTitleColor: UIColor) -> ModalConfiguration {
        self.secondaryButtonTitleColor = secondaryButtonTitleColor
        return self
    }
    
    public func setSecondaryButtonHeight(_ secondaryButtonHeight: CGFloat) -> ModalConfiguration {
        self.secondaryButtonHeight = secondaryButtonHeight
        return self
    }
    
    public func setSecondaryButtonCornerRadius(_ secondaryButtonCornerRadius: CGFloat) -> ModalConfiguration {
        self.secondaryButtonCornerRadius = secondaryButtonCornerRadius
        return self
    }
    
    public func setSecondaryButtonBorderWidth(_ secondaryButtonBorderWidth: CGFloat) -> ModalConfiguration {
        self.secondaryButtonBorderWidth = secondaryButtonBorderWidth
        return self
    }
    
    public func setSecondaryButtonBorderColor(_ secondaryButtonBorderColor: UIColor) -> ModalConfiguration {
        self.secondaryButtonBorderColor = secondaryButtonBorderColor
        return self
    }
    
    public func setShowButtons(_ showButtons: Bool) -> ModalConfiguration {
        self.showButtons = showButtons
        return self
    }
    
    public func setButtonsVerticalCenteredToBottom(_ buttonsVerticalCenteredToBottom: Bool) -> ModalConfiguration {
        self.buttonsVerticalCenteredToBottom = buttonsVerticalCenteredToBottom
        return self
    }
    
    public func setButtonPadAligment(_ buttonPadAligment: ButtonPadAlign) -> ModalConfiguration {
        self.buttonPadAligment = buttonPadAligment
        return self
    }
    
    public func setButtonsPadSpacing(_ buttonsPadSpacing: CGFloat) -> ModalConfiguration {
        self.buttonsPadSpacing = buttonsPadSpacing
        return self
    }
    
    public func setButtonsPadHorizontalPadding(_ buttonsPadHorizontalPadding: CGFloat) -> ModalConfiguration {
        self.buttonsPadHorizontalPadding = buttonsPadHorizontalPadding
        return self
    }
    
    public func setButtonsPadBottomPadding(_ buttonsPadBottomPadding: CGFloat) -> ModalConfiguration {
        self.buttonsPadBottomPadding = buttonsPadBottomPadding
        return self
    }
    
    public func setBackgroundTapDismissView(_ backgroundTapDismissView: Bool) -> ModalConfiguration {
        self.backgroundTapDismissView = backgroundTapDismissView
        return self
    }
    
    public func setCloseButtonPaddingTop(_ closeButtonPaddingTop: CGFloat) -> ModalConfiguration {
        self.closeButtonPaddingTop = closeButtonPaddingTop
        return self
    }
    
    public func setCloseButtonPaddingRight(_ closeButtonPaddingRight: CGFloat) -> ModalConfiguration {
        self.closeButtonPaddingRight = closeButtonPaddingRight
        return self
    }

    public func setCloseButtonHeight(_ closeButtonHeight: CGFloat) -> ModalConfiguration {
        self.closeButtonHeight = closeButtonHeight
        return self
    }
    
    public func setCloseButtonWidth(_ closeButtonWidth: CGFloat) -> ModalConfiguration {
        self.closeButtonWidth = closeButtonWidth
        return self
    }
    
    public func setShowCloseButton(_ showCloseButton: Bool) -> ModalConfiguration {
        self.showCloseButton = showCloseButton
        return self
    }
    
    public func setButtonsPadCornerRadius(_ buttonsPadCornerRadius: CGFloat) -> ModalConfiguration {
        self.buttonsPadCornerRadius = buttonsPadCornerRadius
        return self
    }
    
    public func setUnderlineButtonsWhenHasNoBackgroundColor(_ underlineButtonsWhenHasNoBackgroundColor: Bool) -> ModalConfiguration {
        self.underlineButtonsWhenHasNoBackgroundColor = underlineButtonsWhenHasNoBackgroundColor
        return self
    }
    
}
