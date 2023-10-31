//
//  UIViewController+ModalView.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

public extension UIViewController {

    /// Present an ModalViewController overFullScreen.
    /// - Parameters:
    ///   - configuraction: (ModalConfiguration) Model used to configure the view.
    ///   - primaryCompletion: Right button event.
    ///   - secondaryCompletion: Left button event.
    ///   - closeTapDismissViewCompletion: Close button event.
    ///   - backgroundTapDismissViewCompletion: Background view tap event.
    func showModal(_ configuraction: ModalConfiguration,
                   primaryCompletion: CompletionHandler? = nil,
                   secondaryCompletion: CompletionHandler? = nil,
                   closeTapDismissViewCompletion: CompletionHandler? = nil,
                   backgroundTapDismissViewCompletion: CompletionHandler? = nil) {
        let viewController = ModalViewController()
        viewController.config(configuraction,
                              primaryCompletion: primaryCompletion,
                              secondaryCompletion: secondaryCompletion,
                              closeTapDismissViewCompletion: closeTapDismissViewCompletion,
                              backgroundTapDismissViewCompletion: backgroundTapDismissViewCompletion)
        presentBottomModal(viewController)
    }
}
