//
//  UIViewExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 7/09/22.
//

import Foundation

extension UIView {
    
    // MARK: - SafeArea
    
    /// Bool indicating if the current window has SafeArea
    var windowHasSafeArea: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }

    /// Bool indicating if the current window has botton SafeArea
    var windowHasBottomSafeArea: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0 > 0
    }
    
    var windowHasNotSafeArea: Bool { !windowHasSafeArea }
    
    var windowHasNotBottomSafeArea: Bool { !windowHasBottomSafeArea }
    
}
