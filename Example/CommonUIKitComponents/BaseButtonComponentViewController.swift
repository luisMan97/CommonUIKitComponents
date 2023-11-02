//
//  BaseButtonComponentViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 1/11/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class BaseButtonComponentViewController: UIViewController {

    private let buttonComponent: BaseButtonComponent = {
        let config = ButtonConfig(buttonColor: .blue,
                                  iconState: .none,
                                  initialState: .disabled,
                                  frame: .zero,
                                  size: .medium,
                                  font: .systemFont(ofSize: 14),
                                  title: "Aplicar")
        return BaseButtonComponent(config: config)
    }()

    private var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        bind()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.buttonComponent.setEnable()
        }
    }

}

// MARK: - Private Methods
private extension BaseButtonComponentViewController {
    func addSubviews() {
        view.addSubview(buttonComponent.buttonView)
        addConstraints()
    }

    func addConstraints() {
        buttonComponent.buttonView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                          left: view.leftAnchor,
                                          paddingLeft: 12,
                                          right: view.rightAnchor,
                                          paddingRight: 12,
                                          height: 56)
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
