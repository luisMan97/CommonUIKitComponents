//
//  UIImageViewExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 24/02/23.
//

import UIKit

public extension UIImageView {

    func rotate(withAngle angle: Double,
                animated: Bool) {
        let duration = animated ? 0.5 : 0
        UIView.animate(withDuration: duration) {
            self.transform = .init(rotationAngle: .init(angle))
        }
    }

}
