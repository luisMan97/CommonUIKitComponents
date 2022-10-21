//
//  BaseUIView.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

/**
 A base view to derive from instead directly from UIView.
 Override `configureView` to set up the view hierarchy and layout.
 */
open class BaseUIView: UIView {

    // MARK: - Initializers

    public init() {
        super.init(frame: .zero)
        configureView()
    }

    @available(*, deprecated, message: "Use `init()` instead.")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    @available(*, unavailable, message: "Instantiating via Xib & Storyboard is prohibited, use BaseUINibView instead.")
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }

    // MARK: - Open Methods

    /**
     Builds up the view hierarchy and applies the layout.
     Subclasses should override this method to set up the view's content and layout.
     The base implementation does nothing.
     */
    open func configureView() {
        // Needs to be implemented by subclasses.
    }
}
