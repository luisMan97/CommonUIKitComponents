//
//  BaseComponentView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 20/12/22.
//

import UIKit

public class BaseComponentView: BaseUIView {
    
    // MARK: - Public Properties

    public var componentInset: UIEdgeInsets = .zero {
        didSet {
            topConstraint?.constant = componentInset.top
            leadingConstraint?.constant = componentInset.left
            trailingConstraint?.constant = -componentInset.right
            bottomConstraint?.constant = -componentInset.bottom
        }
    }
    
    public var trailingConstraintConstant: CGFloat? {
        get { trailingConstraint?.constant }
        set { trailingConstraint?.constant = newValue ?? 0 }
    }
    
    public var leadingConstraintConstant: CGFloat? {
        get { leadingConstraint?.constant }
        set { leadingConstraint?.constant = newValue ?? 0 }
    }
    
    public var topConstraintConstant: CGFloat? {
        get { topConstraint?.constant }
        set { topConstraint?.constant = newValue ?? 0 }
    }
    
    public var bottomConstraintConstant: CGFloat? {
        get { bottomConstraint?.constant }
        set { bottomConstraint?.constant = newValue ?? 0 }
    }
    
    // MARK: - Internal Properties
        
    public var trailingConstraint: NSLayoutConstraint?
    public var leadingConstraint: NSLayoutConstraint?
    public var topConstraint: NSLayoutConstraint?
    public var bottomConstraint: NSLayoutConstraint?
    
    // MARK: - Override Methods
    
    public override func configureView() {
        super.configureView()
        basicSetup()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public Methods
    
    /// This method will be called after loading from nib and it is intended for overriding
    public func basicSetup() {
        
    }
    
    public func updateComponentInsets(_ insets: UIEdgeInsets) {
        componentInset = insets
        setNeedsLayout()
    }
    
}
