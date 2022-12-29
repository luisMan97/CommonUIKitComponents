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
    
    static var accentAStart : UIColor {
        #colorLiteral(red: 0.3945618272, green: 0.6816452146, blue: 1, alpha: 1)
    }
    
    static var accentAEnd : UIColor {
        #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
    }
    
    static var borderTransparent: UIColor {
        #colorLiteral(red: 0.08235282451, green: 0.08235301822, blue: 0.08665157109, alpha: 0.202995654) // dark color #colorLiteral(red: 0.1598878801, green: 0.1648689508, blue: 0.1733712554, alpha: 0.2)
    }
    
    static var borderOpaque: UIColor {
        #colorLiteral(red: 0.9677421451, green: 0.9727138877, blue: 0.9769311547, alpha: 1) // dark color #colorLiteral(red: 0.06274487078, green: 0.06274528056, blue: 0.07132229954, alpha: 1)
    }
    
    static var primaryA: UIColor {
        #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // dark color #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    static var primaryB: UIColor {
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // dark color #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var accentA: UIColor {
        #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
    }
    
    static var contentA: UIColor {
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // dark color #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    static var contentC: UIColor {
        #colorLiteral(red: 0.7013711333, green: 0.7263011336, blue: 0.7602098584, alpha: 1) // dark color #colorLiteral(red: 0.2727082074, green: 0.2826777995, blue: 0.2996693254, alpha: 1)
    }
    
    static var overlayA: UIColor {
        #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 0.8)
    }
    
    static var overlayB: UIColor {
        #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
    
    static var positive: UIColor {
        #colorLiteral(red: 0.1654615104, green: 0.8474719524, blue: 0.5199100375, alpha: 1)
    }
    
}
