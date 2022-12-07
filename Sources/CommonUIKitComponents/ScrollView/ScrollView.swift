//
//  ScrollView.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 7/09/22.
//

import UIKit

public class ScrollView: BaseUIView {

    private var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private var scrollViewHeight: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    public var addedScrollViewHeightIfNeeded = false
    
    // MARK: - Override Methods

    public override func configureView() {
        super.configureView()
        backgroundColor = .white
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async { self.addedScrollViewHeight() }
    }
    
    // MARK: - Public Methods

    public func addContainerView(_ view: UIView) {
        addSubViews(containerView: view)
    }

    // MARK: - Private Methods

    private func addSubViews(containerView: UIView) {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        addConstraints(containerView: containerView)
    }

    private func addConstraints(containerView: UIView) {
        // scrollView
        scrollView.anchor(top: topAnchor,
                          bottom: bottomAnchor)
        scrollView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        // containerStackView
        containerView.anchor(top: scrollView.topAnchor,
                             bottom: scrollView.bottomAnchor)
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    // This method is necessary when the parent view has not top o botton constraints, or the top o botton constraints is greaterThanOrEqualTo/lessThanOrEquealTo
    private func addedScrollViewHeight() {
        guard addedScrollViewHeightIfNeeded else {
            return
        }
        
        if let scrollViewHeight = scrollViewHeight {
            scrollViewHeight.isActive = false
        }
        
        if scrollView.contentSize.height == 0 {
            scrollView.setNeedsLayout()
            scrollView.layoutIfNeeded()
        }
        
        scrollViewHeight = scrollView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height)
        scrollViewHeight?.priority = .required - 1
        scrollViewHeight?.isActive = true
    }

}
