//
//  ButtonConfig.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public final class ButtonConfig {
    private var title: String?
    private var font: UIFont?
    private var textColor: UIColor?
    private var buttonColor: UIColor
    private var borderColor: UIColor?
    private var iconAlignment: IconAlignment
    private var iconImage: UIImage?
    private var iconColor: UIColor?
    var state: ButtonState
    private var frame: CGRect
    var size: ButtonSize
    let allowHapticFeedback: Bool

    public init(buttonColor: UIColor,
                iconState: IconAlignment,
                initialState: ButtonState,
                frame: CGRect, size: ButtonSize,
                font: UIFont? = nil,
                title: String? = nil,
                textColor: UIColor? = nil,
                borderColor: UIColor? = nil,
                imageColor: UIColor? = nil,
                iconImage: UIImage? = nil,
                allowHapticFeedback: Bool = true) {
        self.title = title
        self.font = font
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.borderColor = borderColor
        self.iconAlignment = iconState
        self.iconImage = iconImage
        self.iconColor = imageColor
        self.state = initialState
        self.frame = frame
        self.size = size
        self.allowHapticFeedback = true
    }

    var titleString: String? { title }
    var titlefont: UIFont? { font }
    var titleColor: UIColor? { textColor }
    var backgroundColor: UIColor { buttonColor }
    var border: UIColor? { borderColor }
    var imageAlignment: IconAlignment { iconAlignment }
    var image: UIImage? { iconImage }
    var imageColor: UIColor? { iconColor }

    var width: CGFloat { frame.width }
    
    var height: CGFloat {
        var value: CGFloat = 0
        switch size {
        case .large:
            value = frame.height
        case .medium:
            value = frame.height * 6 / 7
        case .small:
            value = frame.height * 4 / 7
        default:
            value = frame.height
        }
        return value
    }

    init() {
        title = ""
        font = UIFont(name: "PPObjectSans-Bold", size: 16)
        textColor = .black
        buttonColor = .blue
        borderColor = .borderTransparent
        iconAlignment = .none
        state = .enable
        self.frame = CGRect(x: .zero,
                            y: .zero,
                            width: .zero,
                            height: 60)
        size = .large
        allowHapticFeedback = true
    }
}
