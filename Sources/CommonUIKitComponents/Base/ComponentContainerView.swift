//
//  ComponentContainerView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 20/12/22.
//

import UIKit

public class ComponentContainerView: BaseUIView {

    private var topConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var leadingConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?

    var componentInset: UIEdgeInsets = .zero {
        didSet {
            topConstraint?.constant = componentInset.top
            leadingConstraint?.constant = componentInset.left
            trailingConstraint?.constant = -componentInset.right
            bottomConstraint?.constant = -componentInset.bottom
        }
    }

    func add(component: UIView) {
        component.translatesAutoresizingMaskIntoConstraints = false
        addSubview(component)
        let leadingConstraint = component.leadingAnchor.constraint(equalTo: leadingAnchor, constant: componentInset.left)
        let topConstraint = component.topAnchor.constraint(equalTo: topAnchor, constant: componentInset.top)
        let trailingConstraint = component.trailingAnchor.constraint(equalTo: trailingAnchor, constant: componentInset.right)
        let bottomConstraint = component.bottomAnchor.constraint(equalTo: bottomAnchor, constant: componentInset.bottom)
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
        self.leadingConstraint = leadingConstraint
        self.topConstraint = topConstraint
        self.trailingConstraint = trailingConstraint
        self.bottomConstraint = bottomConstraint
    }

}
