//
//  UIRectCornerExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

extension UIRectCorner {

    var mask: CACornerMask? {
        guard self != .allCorners else { return nil }
        var cornerMask = CACornerMask()
        if contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }

}
