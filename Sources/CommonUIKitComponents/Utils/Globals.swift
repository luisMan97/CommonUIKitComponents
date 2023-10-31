//
//  Globals.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import Foundation

// MARK: - Typealias

public typealias CompletionHandler = () -> Void
public typealias GenericCompletionHandler<T> = (T) -> Void

// MARK: - Public Variables

public var appWindow: UIWindow? { UIApplication.shared.delegate?.window ?? nil }

public var keyWindow: UIWindow? { UIApplication.shared.keyWindow }

public var windowRootViewController: UIViewController? { appWindow?.rootViewController }

public var windowTopViewController: UIViewController? {
    func finder(from viewController: UIViewController?) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return finder(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return finder(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return finder(from: presentedViewController)
        } else {
            return viewController
        }
    }
    return finder(from: windowRootViewController)
}

// MARK: - Public Functions

public func bundleFor(root object: AnyClass, name: String) -> Bundle? {
    guard let path = Bundle(for: object).path(forResource: name, ofType: "bundle"), let bundle = Bundle(path: path) else { return nil }
    return bundle
}

public func bundleForXib<T: NSObject>(type: T.Type) -> Bundle {
    let defaultBundle = Bundle(for: T.classForCoder())
    let name = String(describing: type)

    if let podName = String(reflecting: type).split(separator: ".").first,
        let resourcesBundle = bundleFor(root: T.classForCoder(), name: podName + "Resources"),
        resourcesBundle.has(xib: name) { return resourcesBundle }

    if defaultBundle.has(xib: name) { return defaultBundle }
    
    if !Bundle.main.has(xib: name) {
        print("The xib named: " + name + " isn't in the resources bundle neither in the class bundle or in the main bundle, this message only tells you that the application will crash 🧨")
    }
    return .main
}
