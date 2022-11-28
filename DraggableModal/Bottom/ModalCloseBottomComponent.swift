//
//  ModalCloseBottomComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 27/11/22.
//

import UIKit

public final class ModalCloseBottomComponent: BottomViewComponent {
    
    private let component: ModalCloseBottomView

    public var base: UIView { component }

    public var onClose: Observable<Void> { component.onClose }

    public init(frame: CGRect = .zero) {
        component = ModalCloseBottomView(frame: frame)
    }

    public func viewDidLoad() {
        component.viewDidLoad()
    }

    public func animateAppear(_ appeared: Bool) {
        component.animateAppear(appeared)
    }
}
