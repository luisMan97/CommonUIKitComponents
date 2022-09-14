//
//  ModalBuilder.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import Foundation
import UIKit

public class ModalConfiguration {
    
    // MARK: - Internal Properties
    
    private(set) var cornerRadius: CGFloat
    private(set) var roundOnlyTopCorners: Bool
    private(set) var customView: UIView?
    private(set) var primaryActionText: String
    private(set) var secondaryActionText: String?
    private(set) var showButtons: Bool
    private(set) var primaryButtonColor: UIColor?
    private(set) var secondaryButtonColor: UIColor?
    private(set) var primaryButtonTitleColor: UIColor?
    private(set) var secondaryButtonTitleColor: UIColor?
    private(set) var primaryButtonCornerRadius: CGFloat
    private(set) var secondaryButtonCornerRadius: CGFloat
    private(set) var buttonPadAligment: ButtonPadAlign
    private(set) var backgroundTapDismissView: Bool
    private(set) var closeButtonPaddingTop: CGFloat
    private(set) var closeButtonPaddingRight: CGFloat
    private(set) var closeButtonHeight: CGFloat
    private(set) var closeButtonWidth: CGFloat
    private(set) var buttonsPadSpacing: CGFloat
    private(set) var buttonsPadHorizontalPadding: CGFloat
    private(set) var buttonsPadBottomPadding: CGFloat
    private(set) var buttonsPadCornerRadius: CGFloat
    private(set) var underlineButtonsWhenHasNoBackgroundColor: Bool
    
    // MARK: - Initializers
    
    public init(cornerRadius: CGFloat = 8,
                roundOnlyTopCorners: Bool = false,
                customView: UIView? = nil,
                primaryActionText: String = "Aceptar",
                primaryButtonColor: UIColor? = .blue,
                primaryButtonTitleColor: UIColor? = nil,
                primaryButtonCornerRadius: CGFloat = 8,
                secondaryActionText: String? = nil,
                secondaryButtonColor: UIColor? = .lightGray.withAlphaComponent(0.3),
                secondaryButtonTitleColor: UIColor? = .black,
                secondaryButtonCornerRadius: CGFloat = 8,
                showButtons: Bool = true,
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
                underlineButtonsWhenHasNoBackgroundColor: Bool = false) {
        self.cornerRadius = cornerRadius
        self.roundOnlyTopCorners = roundOnlyTopCorners
        self.customView = customView
        self.primaryActionText = primaryActionText
        self.primaryButtonColor = primaryButtonColor
        self.primaryButtonTitleColor = primaryButtonTitleColor
        self.primaryButtonCornerRadius = primaryButtonCornerRadius
        self.secondaryActionText = secondaryActionText
        self.secondaryButtonColor = secondaryButtonColor
        self.secondaryButtonTitleColor = secondaryButtonTitleColor
        self.secondaryButtonCornerRadius = secondaryButtonCornerRadius
        self.showButtons = showButtons
        self.buttonPadAligment = buttonPadAligment
        self.buttonsPadSpacing = buttonsPadSpacing
        self.buttonsPadHorizontalPadding = buttonsPadHorizontalPadding
        self.buttonsPadBottomPadding = buttonsPadBottomPadding
        self.backgroundTapDismissView = backgroundTapDismissView
        self.closeButtonPaddingTop = closeButtonPaddingTop
        self.closeButtonPaddingRight = closeButtonPaddingRight
        self.closeButtonHeight = closeButtonHeight
        self.closeButtonWidth = closeButtonWidth
        self.buttonsPadCornerRadius = buttonsPadCornerRadius
        self.underlineButtonsWhenHasNoBackgroundColor = underlineButtonsWhenHasNoBackgroundColor
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
    
    public func setPrimaryActionText(_ primaryActionText: String) -> ModalConfiguration {
        self.primaryActionText = primaryActionText
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
    
    public func setPrimaryButtonCornerRadius(_ primaryButtonCornerRadius: CGFloat) -> ModalConfiguration {
        self.primaryButtonCornerRadius = primaryButtonCornerRadius
        return self
    }
    
    public func setSecondaryActionText(_ secondaryActionText: String) -> ModalConfiguration {
        self.secondaryActionText = secondaryActionText
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
    
    public func setSecondaryButtonCornerRadius(_ secondaryButtonCornerRadius: CGFloat) -> ModalConfiguration {
        self.secondaryButtonCornerRadius = secondaryButtonCornerRadius
        return self
    }
    
    public func setShowButtons(_ showButtons: Bool) -> ModalConfiguration {
        self.showButtons = showButtons
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
    
    public func setcloseButtonPaddingRight(_ closeButtonPaddingRight: CGFloat) -> ModalConfiguration {
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
    
    public func setButtonsPadCornerRadius(_ buttonsPadCornerRadius: CGFloat) -> ModalConfiguration {
        self.buttonsPadCornerRadius = buttonsPadCornerRadius
        return self
    }
    
    public func setUnderlineButtonsWhenHasNoBackgroundColor(_ underlineButtonsWhenHasNoBackgroundColor: Bool) -> ModalConfiguration {
        self.underlineButtonsWhenHasNoBackgroundColor = underlineButtonsWhenHasNoBackgroundColor
        return self
    }
    
}
