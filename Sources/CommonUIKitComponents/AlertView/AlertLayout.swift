//
//  AlertLayout.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

enum AlertLayout {
    // containerStackView
    static let containerStackViewPaddingTop: CGFloat = 34.1
    static let containerStackViewPaddingBottom: CGFloat = 32
    // errorImage
    static let errorImageSize: CGFloat = 51.8
    // titleLabel
    static let titleLabelFontSize: CGFloat = 18
    static let titleLabelHorizontalPadding: CGFloat = 24
    static let titleLabelPaddingTop: CGFloat = 34.1
    static var titleLabelInsets: UIEdgeInsets {
        .init(top: titleLabelPaddingTop,
              left: titleLabelHorizontalPadding,
              bottom: .zero,
              right: titleLabelHorizontalPadding)
    }
    // messageLabel
    static let messageLabelFontSize: CGFloat = 15
    static let messageLabelPaddingTop: CGFloat = 12
    static let messageLabelHorizontalPadding: CGFloat = 32
    static var messageLabelInsets: UIEdgeInsets {
        .init(top: messageLabelPaddingTop,
              left: messageLabelHorizontalPadding,
              bottom: .zero,
              right: messageLabelHorizontalPadding)
    }
}
