//
//  UIButtonExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 1/09/22.
//

import UIKit

public extension UIButton {

    func underline() {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: (tittleText.count)))
        self.setAttributedTitle(attributedString, for: .normal)
    }

    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let isRTL = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
        if isRTL {
            imageEdgeInsets = .init(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            titleEdgeInsets = .init(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            contentEdgeInsets = .init(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
        } else {
            imageEdgeInsets = .init(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = .init(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = .init(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }

    /// Makes the ``imageView`` appear just to the right of the ``titleLabel``.
    /// If alignToSides is true, spacing is ignored
    func alignImageRight(alignToSides: Bool = true,
                         spacing: CGFloat = 20) {
        DispatchQueue.main.async { [self] in
            guard let titleLabel = titleLabel, let imageView = imageView else {
                return
            }
            if alignToSides {
                imageEdgeInsets = .init(top: 0,
                                        left: bounds.width - imageView.frame.size.width,
                                        bottom: 0,
                                        right: 0)
                titleEdgeInsets = .init(top: 0,
                                        left: -imageView.bounds.width,
                                        bottom: 0,
                                        right: 0)
                contentHorizontalAlignment = .left
            } else {
                let spacing = titleLabel.frame.width + spacing
                titleEdgeInsets = .init(top: 0,
                                        left: -imageView.frame.width,
                                        bottom: 0,
                                        right: imageView.frame.width)
                imageEdgeInsets = .init(top: 0,
                                        left: spacing,
                                        bottom: 0,
                                        right: -spacing)
            }
        }
    }

}
