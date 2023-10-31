//
//  UIView+CornerRadius.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public extension UIView {

    /// - Parameters:
    ///   - conersType:
    ///     layerMaxXMaxYCorner – lower right corner
    ///     layerMaxXMinYCorner – top right corner
    ///     layerMinXMaxYCorner – lower left corner
    ///     layerMinXMinYCorner – top left corner
    ///   - cornerRadius: radius for selected corners.
    func roundCornersWith(borderColor: UIColor? = nil,
                          borderWidth: CGFloat? = nil,
                          cornerRadius: CGFloat,
                          conersType: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius
        if let conersType = conersType { layer.maskedCorners = conersType }
        if let borderColor = borderColor { layer.borderColor = borderColor.cgColor }
        if let borderWidth = borderWidth { layer.borderWidth = borderWidth }
        clipsToBounds = true
    }

    func roundTopCornersWith(borderColor: UIColor? = nil,
                             borderWidth: CGFloat? = nil,
                             cornerRadius: CGFloat) {
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner,
                                           .layerMaxXMinYCorner]
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius, conersType: maskedCorners)
    }

    func roundBottomCornersWith(borderColor: UIColor? = nil,
                                borderWidth: CGFloat? = nil,
                                cornerRadius: CGFloat) {
        let maskedCorners: CACornerMask = [.layerMinXMaxYCorner,
                                           .layerMaxXMaxYCorner]
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius, conersType: maskedCorners)
    }

    func roundAllCornersWith(borderColor: UIColor? = nil,
                             borderWidth: CGFloat? = nil,
                             cornerRadius: CGFloat) {
        roundCornersWith(borderColor: borderColor, borderWidth: borderWidth, cornerRadius: cornerRadius)
    }

    func setupRoundedCorners(radius: CGFloat,
                             corners: UIRectCorner = .allCorners) {
        setupRoundedCorners(radius: radius, corners: corners, smoothCorners: true)
    }

    func setupRoundedCorners(radius: CGFloat,
                             corners: UIRectCorner = .allCorners,
                             smoothCorners: Bool) {
        layer.cornerRadius = radius
        if smoothCorners {
            if #available(iOS 13.0, *) {
                layer.cornerCurve = .continuous
            }
        }
        clipsToBounds = true
        if let mask = corners.mask {
            layer.maskedCorners = mask
        }
        if layer.shadowPath != nil {
            createCachedShadow()
        }
    }

    func createCachedShadow() {
        let origin = CGPoint(x: bounds.origin.x + layer.shadowOffset.width,
                             y: bounds.origin.y + layer.shadowOffset.height)
        let size = CGSize(width: bounds.size.width + layer.shadowOffset.width,
                          height: bounds.size.height + layer.shadowOffset.height)
        let rect = CGRect(origin: origin,
                          size: size)
        let path: UIBezierPath
        if layer.cornerRadius > 0 {
            let maskedRect = layer.maskedCorners.rect
            if maskedRect == .allCorners {
                path = UIBezierPath(roundedRect: rect,
                                    cornerRadius: layer.cornerRadius)
            } else {
                path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: maskedRect,
                                    cornerRadii: CGSize(width: layer.cornerRadius,
                                                        height: layer.cornerRadius))
            }
        } else {
            path = UIBezierPath(rect: rect)
        }
        layer.shadowPath = path.cgPath
    }

}

