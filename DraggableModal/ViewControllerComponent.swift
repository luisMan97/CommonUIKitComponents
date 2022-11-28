//
//  ViewControllerComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 27/11/22.
//

import UIKit

// ViewControllerComponent is used to expose a series of possible actions when using a component of type UIViewController
public protocol ViewControllerComponent: ViewComponent {
    var viewControllerActions: ViewControllerActions { get }
    func present(over baseController: UIViewController?, completion: (() -> Void)?)
    func present(above viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func push(in navigationController: UINavigationController?, completion: (() -> Void)?)
}
