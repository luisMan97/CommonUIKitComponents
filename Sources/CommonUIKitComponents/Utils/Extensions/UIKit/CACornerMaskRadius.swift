//
//  CACornerMaskRadius.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

extension CACornerMask {

    var rect: UIRectCorner {
        var cornersCount = 0
        var rect = UIRectCorner()
        if contains(.layerMinXMinYCorner) {
            rect.insert(.topLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMinYCorner) {
            rect.insert(.topRight)
            cornersCount += 1
        }
        if contains(.layerMinXMaxYCorner) {
            rect.insert(.bottomLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMaxYCorner) {
            rect.insert(.bottomRight)
            cornersCount += 1
        }
        guard cornersCount != 4 else { return .allCorners }
        return rect
    }

}
