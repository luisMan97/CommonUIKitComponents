//
//  UIViewExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 7/09/22.
//

import UIKit

public
extension UIView {
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    class func getAllSubviews<T: UIView>(from parenView: UIView) -> [T] {
        return parenView.subviews.flatMap { subView -> [T] in
            var result = [T]()

            if let view = subView as? T {
                result.append(view)
            } else {
                let subViewResult = getAllSubviews(from: subView) as [T]
                result.append(contentsOf: subViewResult)
            }

            return result
        }
    }
    
    func setupBorder(width: CGFloat = 1.0, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    // MARK: - SafeArea
    
    /// Bool indicating if the current window has SafeArea
    var windowHasSafeArea: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return appWindow?.safeAreaInsets.top ?? 0 > 20
    }

    /// Bool indicating if the current window has botton SafeArea
    var windowHasBottomSafeArea: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        return appWindow?.safeAreaInsets.bottom ?? 0 > 0
    }
    
    var windowHasNotSafeArea: Bool { !windowHasSafeArea }
    
    var windowHasNotBottomSafeArea: Bool { !windowHasBottomSafeArea }
    
}
