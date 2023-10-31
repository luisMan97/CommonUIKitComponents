//
//  BaseModalHeaderComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import Foundation

public final class BaseModalHeaderComponent: ModalHeaderComponent {

    private let component: BaseModalHeaderView

    public var isHeaderOnTop: Bool = false {
        didSet {
            component.setup(state: isHeaderOnTop ? .fullscreen : .modal)
        }
    }

    public var base: UIView {
        return component
    }

    public var height: CGFloat {
        return component.calculateAppropriateHeight()
    }

    public var titleTapper: Observable<Void>? {
        return component.titleTapper()
    }

    public var collectionOffset: CGPoint? {
        didSet {
            component.collectionDidScroll(collectionOffset)
        }
    }

    public var isFloating: Bool {
        component.isFloating
    }

    public init(config: BaseModalHeaderConfig) {

        switch config.style {

        case .large:
            component = LargeTitleHeaderView(frame: .zero,
                                             config: config)
        case .small:
            component = SmallTitleHeaderView(frame: .zero,
                                             config: config)
        }
    }
}
