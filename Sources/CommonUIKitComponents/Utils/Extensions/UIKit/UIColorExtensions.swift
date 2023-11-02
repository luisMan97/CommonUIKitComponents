//
//  UIColorExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public extension UIColor {

    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }

    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }

    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = String(hex.prefix(1))
        }
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        var red: UInt32?
        var green: UInt32?
        var blue: UInt32?
        switch (hexWithoutSymbol.count) {
        case 3: // #RGB
            red = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            green = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            blue = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
        case 6: // #RRGGBB
            red = (hexInt >> 16) & 0xff
            green = (hexInt >> 8) & 0xff
            blue = hexInt & 0xff
        default: break
        }

        guard let red = red,
              let green = green,
              let blue = blue else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }

        self.init(red: (CGFloat(red) / 255),
                  green: (CGFloat(green) / 255),
                  blue: (CGFloat(blue) / 255),
                  alpha: alpha)
    }

    static var borderTransparent: UIColor {
        .lightGray.withAlphaComponent(0.25)
    }

    static var borderOpaque: UIColor {
        .lightGray.withAlphaComponent(0.09)
    }

    static var overlayA: UIColor {
        .white.withAlphaComponent(0.8)
    }

    static var overlayB: UIColor {
        .black.withAlphaComponent(0.8)
    }

}
