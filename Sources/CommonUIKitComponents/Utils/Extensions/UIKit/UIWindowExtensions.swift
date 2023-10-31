//
//  UIWindowExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 24/02/23.
//

import Foundation

public extension UIWindow {

    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }

}
