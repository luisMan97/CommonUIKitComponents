//
//  ViewControllerComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// ViewControllerComponent is used to expose a series of possible actions when using a component of type UIViewController
public protocol ViewControllerComponent: ViewComponent {
    var viewControllerActions: ViewControllerActions { get }
    func present(over baseController: UIViewController?,
                 completion: CompletionHandler?)
    func present(above viewController: UIViewController,
                 animated: Bool,
                 completion: CompletionHandler?)
    func push(in navigationController: UINavigationController?,
              completion: CompletionHandler?)
}

// MARK: - ViewControllerComponent Default Implementations
public extension ViewControllerComponent {
    func present(over baseController: UIViewController?,
                 completion: CompletionHandler?) {}
    func push(in navigationController: UINavigationController?,
              completion: CompletionHandler?) {}
}

