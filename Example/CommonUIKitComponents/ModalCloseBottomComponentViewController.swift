//
//  ModalCloseBottomViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 1/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class ModalCloseBottomViewController: UIViewController {

    private lazy var modalCloseBottomComponent: ModalCloseBottomComponent = {
        let component = ModalCloseBottomComponent()
        view.addSubview(component.base)
        return component
    }()

    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addConstraints()
        modalCloseBottomComponent.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.modalCloseBottomComponent.animateAppear(true)
        }
    }

}

// MARK: - Private Methods
private extension ModalCloseBottomViewController {
    func addConstraints() {
        modalCloseBottomComponent.base.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                              paddingBottom: 16,
                                              width: 48,
                                              height: 48,
                                              centerX: view)
    }
}
