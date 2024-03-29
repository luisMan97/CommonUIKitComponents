//
//  UIStackViewExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public extension UIStackView {

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubviewAndFromSuperview($0)
        }
    }

    func removeArrangedSubviewAndFromSuperview(_ view: UIView) {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
    }

    func addArrangedSubview(_ view: UIView,
                            withMargin margin: UIEdgeInsets,
                            identifier: String = String()) {
        let containerView = UIView()
        containerView.addSubview(view)

        if identifier.isEmpty {
            view.anchor(top: containerView.topAnchor,
                        paddingTop: margin.top,
                        bottom: containerView.bottomAnchor,
                        paddingBottom: margin.bottom,
                        left: containerView.leftAnchor,
                        paddingLeft: margin.left,
                        right: containerView.rightAnchor,
                        paddingRight: margin.right
            )
        } else {
            view.anchor(top: containerView.topAnchor,
                        paddingTop: margin.top,
                        bottom: containerView.bottomAnchor,
                        paddingBottom: margin.bottom,
                        left: containerView.leftAnchor,
                        paddingLeft: margin.left,
                        right: containerView.rightAnchor,
                        paddingRight: margin.right,
                        identifier: identifier
            )
        }

        addArrangedSubview(containerView)
    }
    
    func insertArrangedSubview(_ view: UIView,
                               belowArrangedSubview subview: UIView,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        arrangedSubviews.enumerated().forEach { index, element in
            if element == subview {
                insertArrangedSubview(view,
                                      at: index + 1,
                                      withMargin: margin,
                                      identifier: identifier)
            }
        }
    }

    func insertArrangedSubview(_ view: UIView,
                               belowSubArrangedSubview subview: UIView,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        arrangedSubviews.enumerated().forEach { index, element in
            if element.subviews.contains(subview) {
                insertArrangedSubview(view,
                                      at: index + 1,
                                      withMargin: margin,
                                      identifier: identifier)
            }
        }
    }

    func insertArrangedSubview(_ view: UIView,
                               aboveArrangedSubview subview: UIView,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        arrangedSubviews.enumerated().forEach { index, element in
            if element == subview {
                insertArrangedSubview(view,
                                      at: index,
                                      withMargin: margin,
                                      identifier: identifier)
            }
        }
    }

    func insertArrangedSubview(_ view: UIView,
                               aboveSubArrangedSubview subview: UIView,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        arrangedSubviews.enumerated().forEach { index, element in
            if element.subviews.contains(subview) {
                insertArrangedSubview(view,
                                      at: index,
                                      withMargin: margin,
                                      identifier: identifier)
            }
        }
    }

    func insertArrangedSubview(_ view: UIView,
                               at stackIndex: Int,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        let containerView = UIView()
        containerView.addSubview(view)

        if identifier.isEmpty {
            view.anchor(top: containerView.topAnchor,
                        paddingTop: margin.top,
                        bottom: containerView.bottomAnchor,
                        paddingBottom: margin.bottom,
                        left: containerView.leftAnchor,
                        paddingLeft: margin.left,
                        right: containerView.rightAnchor,
                        paddingRight: margin.right
            )
        } else {
            view.anchor(top: containerView.topAnchor,
                        paddingTop: margin.top,
                        bottom: containerView.bottomAnchor,
                        paddingBottom: margin.bottom,
                        left: containerView.leftAnchor,
                        paddingLeft: margin.left,
                        right: containerView.rightAnchor,
                        paddingRight: margin.right,
                        identifier: identifier
            )
        }
        
        insertArrangedSubview(containerView, at: stackIndex)
    }

}
