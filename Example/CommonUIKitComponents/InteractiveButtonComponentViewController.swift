//
//  InteractiveButtonComponentViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 1/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class InteractiveButtonComponentViewController: UIViewController {

    private lazy var buttonComponent: InteractiveButtonComponent = {
        let frame = CGRect(x: .zero,
                           y: .zero,
                           width: 48,
                           height: 48)
        let config = ButtonConfig(
            buttonColor: .blue,
            iconState: .none,
            initialState: .disabled,
            frame: frame,
            size: .square,
            imageColor: .white,
            iconImage: .xmark.withRenderingMode(.alwaysTemplate)
        )
        let component = InteractiveButtonComponent(config: config)
        view.addSubview(component.buttonView)
        return component
    }()

    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addConstraints()
        bind()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.buttonComponent.setEnable()
        }
    }

}

// MARK: - Private Methods
private extension InteractiveButtonComponentViewController {
    func addConstraints() {
        buttonComponent.buttonView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                          width: 48,
                                          height: 48,
                                          centerX: view)
    }

    private func bind() {
        buttonComponent.buttonTapper().observe { [weak self] in
            guard let self else { return }
            isLoading.toggle()
            if isLoading {
                self.buttonComponent.playLoader()
            } else {
                self.buttonComponent.stopLoader()
            }
        }
    }
}
