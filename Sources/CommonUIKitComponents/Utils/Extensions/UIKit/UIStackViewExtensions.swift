//
//  UIStackViewExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public extension UIStackView {
    
    func addArrangedSubview(_ view: UIView, withMargin margin: UIEdgeInsets, identifier: String = String()) {
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
    
}
