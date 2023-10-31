//
//  UIViewControllerExtensions.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

extension UIViewController {

    func presentBottomModal(_ viewController: UIViewController,
                            animated: Bool = true,
                            backgroundAlpha: CGFloat = 0.5,
                            completion: CompletionHandler? = nil) {
        viewController.setDelayBackgroundAlpha(backgroundAlpha)
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: animated, completion: completion)
    }

    func setDelayBackgroundAlpha(_ backgroundAlpha: CGFloat = 0.5,
                                 delay: CGFloat = 0.3,
                                 completion: CompletionHandler? = nil) {
        guard delay > 0 else {
            setBackgroundAlpha(backgroundAlpha, completion: completion)
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.setBackgroundAlpha(backgroundAlpha, completion: completion)
        }
    }

    func setBackgroundAlpha(_ backgroundAlpha: CGFloat = 0.5,
                            completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: 0.4,
                       animations: { [self] in
            view.backgroundColor = .black.withAlphaComponent(backgroundAlpha)
        }, completion: { _ in completion?() })
    }

    func dismissWithEffect(completion: CompletionHandler? = nil) {
        hideWithEffect { [self] in dismiss(animated: false, completion: completion) }
    }

    func hideWithEffect(completion: CompletionHandler? = nil) {
        UIView.animate(withDuration: 0.4,
                       animations: { [self] in
            view.backgroundColor = .black.withAlphaComponent(0)
            view.alpha = 0.5
            view.subviews.forEach { $0.frame.origin.y += UIScreen.main.bounds.height }
        }, completion: { _ in completion?() })
    }

}
