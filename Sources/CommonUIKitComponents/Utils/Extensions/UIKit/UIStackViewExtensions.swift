//
//  UIStackViewExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public extension UIStackView {
    
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
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0 + 1,
                                      withMargin: margin,
                                      identifier: identifier)
            }
        }
    }
    
    func insertArrangedSubview(_ view: UIView,
                               aboveArrangedSubview subview: UIView,
                               withMargin margin: UIEdgeInsets,
                               identifier: String = String()) {
        arrangedSubviews.enumerated().forEach {
            if $0.1 == subview {
                insertArrangedSubview(view, at: $0.0,
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
