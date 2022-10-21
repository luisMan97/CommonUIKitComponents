//
//  UIView+CornerRadius.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

extension UIView {
    
    /// - Parameters:
    ///   - conersType:
    ///     layerMaxXMaxYCorner – lower right corner
    ///     layerMaxXMinYCorner – top right corner
    ///     layerMinXMaxYCorner – lower left corner
    ///     layerMinXMinYCorner – top left corner
    ///   - cornerRadius: radius for selected corners.
    func roundCornersWith(borderColor: CGColor? = nil,
                          borderWidth: CGFloat? = nil,
                          cornerRadius: CGFloat,
                          conersType: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius
        if let conersType = conersType { layer.maskedCorners = conersType }
        if let borderColor = borderColor { layer.borderColor = borderColor }
        if let borderWidth = borderWidth { layer.borderWidth = borderWidth }
        clipsToBounds = true
    }
    
    func roundTopCornersWith(borderColor: CGColor? = nil, borderWidth: CGFloat? = nil, cornerRadius: CGFloat) {
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner,
                                           .layerMaxXMinYCorner]
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius, conersType: maskedCorners)
    }
    
    func roundBottomCornersWith(borderColor: CGColor? = nil, borderWidth: CGFloat? = nil, cornerRadius: CGFloat) {
        let maskedCorners: CACornerMask = [.layerMinXMaxYCorner,
                                           .layerMaxXMaxYCorner]
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius, conersType: maskedCorners)
    }
    
    func roundAllCornersWith(borderColor: CGColor? = nil, borderWidth: CGFloat? = nil, cornerRadius: CGFloat) {
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
    }
    
}

