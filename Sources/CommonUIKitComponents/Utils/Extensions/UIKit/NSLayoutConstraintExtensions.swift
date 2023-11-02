//
//  NSLayoutConstraintExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 1/11/23.
//

import UIKit

public extension NSLayoutConstraint {
    func isActive(_ active: Bool) -> NSLayoutConstraint {
        self.isActive = active
        return self
    }
}
