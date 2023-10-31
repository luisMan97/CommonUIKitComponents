//
//  BaseModalHeaderConfig.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public enum ModalHeaderStyle {
    case small
    case large
}

public struct BaseModalHeaderConfig {
    public let title: NSAttributedString?
    public let subtitle: NSAttributedString?
    public let toptitle: NSAttributedString?
    public let titleRightIcon: UIImage?
    public let contentInsets: UIEdgeInsets
    public let style: ModalHeaderStyle
    public let trailingButtons: [BaseButtonProtocol]?
    public let leadingButtons: [BaseButtonProtocol]?
    public let showDecorator: Bool
    public let decoratorColor: UIColor?
    public let isHidden: Bool
    public let isFloating: Bool
    public let offsetToDisplay: CGFloat?
    public let spaceToTopTitle: CGFloat?

    public init(title: NSAttributedString? = nil,
                subtitle: NSAttributedString? = nil,
                toptitle: NSAttributedString? = nil,
                titleRightIcon: UIImage? = nil,
                contentInsets: UIEdgeInsets? = nil,
                style: ModalHeaderStyle = .large,
                trailingButtons: [BaseButtonProtocol]? = nil,
                leadingButtons: [BaseButtonProtocol]? = nil,
                showDecorator: Bool = true,
                decoratorColor: UIColor? = nil,
                isHidden: Bool = false,
                isFloating: Bool = false,
                offsetToDisplay: CGFloat? = nil,
                spaceToTopTitle: CGFloat? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.toptitle = toptitle
        self.titleRightIcon = titleRightIcon
        self.contentInsets = contentInsets ?? UIEdgeInsets(top: .spacing(6), left: .spacing(6), bottom: .spacing(6), right: .spacing(6))
        self.style = style
        self.trailingButtons = trailingButtons
        self.leadingButtons = leadingButtons
        self.showDecorator = showDecorator
        self.decoratorColor = decoratorColor
        self.isFloating = isFloating
        self.offsetToDisplay = offsetToDisplay
        self.isHidden = isHidden
        self.spaceToTopTitle = spaceToTopTitle
    }
}
