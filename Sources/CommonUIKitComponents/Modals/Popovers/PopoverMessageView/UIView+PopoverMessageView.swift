//
//  UIView+PopoverMessageView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 29/12/22.
//

import UIKit

public extension UIView {

    @discardableResult
    func showCustomPopoverMessage(_ message: String,
                                  size: CGSize) -> UIView {
        let viewPopup = UIView().then {
            parentViewController?.view.addSubview($0)
            $0.setSize(width: size.width + 20,
                       height: size.height + 29)
            $0.addConstraintTop(self)
            $0.addCenterXConstraint(self,
                                    multiplier: 1,
                                    constant: 50)
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                           action: #selector(self.dissmisPopup)))
        }
        let popover = UIView().then {
            viewPopup.addSubview($0)
            $0.backgroundColor = UIColor(hex: "4B4B4B")
            $0.setSize(width: size.width + 20,
                       height: size.height + 20)
            $0.addBottomConstraintParent()
            $0.roundCornersWith(cornerRadius: 11)
            $0.addConstraintXCenterParent()
        }
        UILabel().then {
            popover.addSubview($0)
            $0.addConstraintTopParent(constant: 6)
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
        TriangleView(frame: .zero,
                     color: UIColor(hex: "4B4B4B")).then {
            viewPopup.addSubview($0)
            $0.backgroundColor = .clear
            $0.setSize(width: 13, height: 9)
            $0.addConstraintTopParent()
            $0.addConstraintXCenterParent(multiplier: 1,
                                          constant: -50)
        }
        return viewPopup
    }

    @objc
    func dissmisPopup(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }

}
