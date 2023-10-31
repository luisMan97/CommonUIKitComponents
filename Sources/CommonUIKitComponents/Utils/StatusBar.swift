//
//  StatusBar.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

final class StatusBar {

    var oldStyle: Style = .black
    var currentStyle: Style = .black
    var isHidden = false
    var currentTextColor: UIColor = .primaryB
    var currentBackgroundColors: [UIColor] = [.primaryA]

    static let config = StatusBar()

    var height: CGFloat {
        keyWindow?.safeAreaInsets.top ?? 20.0
    }

    var currentHeight: CGFloat {
        UIApplication.shared.statusBarFrame.height
    }

    func setUp(style: Style) {
        oldStyle = currentStyle
        UIApplication.shared.statusBarView?.backgroundColor = style.backgroudColor
        setTextColor(color: style.textColor)
        currentStyle = style
        currentTextColor = style.textColor
    }

    func setupOldStyle() {
        setUp(style: oldStyle)
        oldStyle = currentStyle
    }

    func setTextColor(color: UIColor) {
        switch color {
        case UIColor.white, .primaryA:
            UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        default:
            UIApplication.shared.setStatusBarStyle(.default, animated: true)
        }
    }
}

extension StatusBar {

    enum Style: Equatable {
        case light
        case black
        case blackTextWhiteBackground
        case custom(textColor: UIColor, backgroundColor: UIColor)
        case automatic

        var textColor: UIColor {
            switch self {
            case .light:
                return .primaryA
            case .black, .blackTextWhiteBackground:
                return .primaryB
            case .custom(let textColor, _):
                return textColor
            case .automatic:
                return .clear
            }
        }

        var backgroudColor: UIColor {
            switch self {
            case .light, .black, .automatic:
                return .clear
            case .blackTextWhiteBackground:
                return .primaryA
            case .custom(_, let backgroundColor):
                return backgroundColor
            }
        }

        static func == (left: Style, right: Style) -> Bool {
            switch (left, right) {
            case (.light, .light):
                return true
            case (.black, .black):
                return true
            case (.blackTextWhiteBackground, .blackTextWhiteBackground):
                return true
            case (.custom, .custom):
                return true
            case (.automatic, .automatic):
                return true
            default:
                return false
            }
        }
    }

}
