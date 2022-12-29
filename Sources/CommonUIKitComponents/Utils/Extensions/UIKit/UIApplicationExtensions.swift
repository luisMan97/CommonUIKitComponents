//
//  UIApplicationExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

public extension UIApplication {

    var statusBarView: UIView? {
        guard !ProcessInfo.processInfo.arguments.contains(where: { $0.contains("xctest") }) else {
            return nil
        }

        if #available(iOS 13.0, *) {
            let tag = 12345
            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let frame = UIApplication.shared.statusBarFrame
                let statusBar = UIView(frame: frame)
                statusBar.tag = tag
                keyWindow?.addSubview(statusBar)
                return statusBar
            }
        } else {
            return value(forKey: "statusBar") as? UIView
        }
    }

}
