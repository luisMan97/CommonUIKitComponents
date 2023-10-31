//
//  PopoverMenuFactory.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

public enum PopoverMenuFactory {

    public static func showPopoverMenu(from view: UIView,
                                       items: [PopoverMenuItem],
                                       callBack: @escaping GenericCompletionHandler<Int>) {
        let viewModel = PopoverMenuViewModel(callBack: callBack)
        let controller = PopoverMenuViewController(viewModel: viewModel)       
        viewModel.items = items
        guard let viewController = view.parentViewController else {
            return
        }
        let height = (items.count * 35) + 5
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 230, height:  height)
        controller.view.backgroundColor = UIColor(hex: "383838")
        controller.popoverPresentationController?.delegate = viewController as? UIPopoverPresentationControllerDelegate
        controller.popoverPresentationController?.permittedArrowDirections = .up
        controller.popoverPresentationController?.sourceView = view
        controller.popoverPresentationController?.sourceRect = view.bounds
        viewController.present(controller, animated: false)
    }

}
