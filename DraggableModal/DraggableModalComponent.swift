//
//  DraggableModalComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 27/11/22.
//

import UIKit

// DraggableModalComponent is used to expose only a series of possible actions on the DraggableModalViewController
public struct DraggableModalComponent: ViewControllerComponent {

    private let component: DraggableModalViewController

    // Use this to get UIView of component
    public var base: UIView { component.view }

    // Use this to subscribe to the component life cycle
    public var viewControllerActions: ViewControllerActions {
        return (
            viewDidLoad: component.didLoad,
            viewWillAppear: component.WillAppear,
            viewDidAppear: component.DidAppear,
            viewDeallocated: component.rx.deallocated,
            viewDismissed: component.didDissmisDrag
        )
    }

    public init(config: DraggableModalConfig) {
        component = DraggableModalViewController(config: config)
    }

    public init(controller: UIViewController, canBeDismissed: Bool) {
        component = DraggableModalViewController(controller: controller, canBeDismissed: canBeDismissed)
    }

    // Use this to present the component over your view controller
    public func present(over baseController: UIViewController?, completion: (() -> Void)? = nil) {
        component.modalPresentationStyle = .overFullScreen
        baseController?.present(component, animated: false, completion: completion)
    }

    // Use this to present any view controller above your component
    public func present(above viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        component.present(viewController, animated: animated, completion: completion)
    }

    // Use this to dismiss your component from external actions
    public func dismiss(completion: (() -> Void)? = nil) {
        component.dismissComponent(completion: completion)
    }
}
