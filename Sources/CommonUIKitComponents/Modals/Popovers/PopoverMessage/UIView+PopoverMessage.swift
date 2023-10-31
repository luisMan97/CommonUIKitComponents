//
//  UIView+PopoverMessage.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

public extension UIView {

    func showPopoverMessage(_ message: String,
                            size: CGSize) {
        let popoverViewController = UIViewController().then {
            $0.view.backgroundColor = UIColor(hex: "4B4B4B")
            $0.preferredContentSize = size
            $0.modalPresentationStyle = .popover
        }
        popoverViewController.popoverPresentationController?.then {
            $0.permittedArrowDirections = .up
            $0.backgroundColor = UIColor(hex: "4B4B4B")
            $0.delegate = parentViewController as? UIPopoverPresentationControllerDelegate
            $0.sourceView = self
            $0.sourceRect = CGRect(x: -35,
                                   y: 20,
                                   width: 100,
                                   height: 1)
        }
        UILabel().then {
            popoverViewController.view.addSubview($0)
            $0.addConstraintTopParent(constant: 14)
            $0.addWidthConstraintParent(multiplier: 0.98)
            $0.addConstraintXCenterParent()
            $0.addBottomConstraintParent()
            $0.numberOfLines = 3
            $0.font = UIFont(name: "Roboto-Regular", size: 12)
            $0.textColor = .white
            $0.text = message
            $0.textAlignment = .center
            $0.adjustsFontSizeToFitWidth = true
            $0.minimumScaleFactor = 0.8
        }
        parentViewController?.present(popoverViewController,
                                      animated: true,
                                      completion: nil)
    }

}
