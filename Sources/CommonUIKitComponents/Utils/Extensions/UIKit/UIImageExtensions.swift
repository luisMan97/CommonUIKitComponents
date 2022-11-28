//
//  UIImageExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import Foundation

public extension UIImage {
    
    static var xmark: UIImage {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "xmark") ?? UIImage()
        } else {
            return UIImage()
        }
    }
    
}

