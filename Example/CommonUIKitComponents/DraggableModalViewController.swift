//
//  DraggableModalViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class DraggableModalViewController: UIViewController {

    // MARK: - Private UI Properties

    private let containerStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .vertical
    }

    private lazy var showButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) { [weak self] in self?.showModal() }
        $0.setTitle("Show DraggableModal whith collecion view", for: .normal)
        $0.underline()
        $0.setTitleColor(.blue, for: .normal)
        $0.isUserInteractionEnabled = true
    }

    private lazy var showSecondButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) { [weak self] in self?.showModalWithViewController() }
        $0.setTitle("Show DraggableModal whith view controller", for: .normal)
        $0.underline()
        $0.setTitleColor(.blue, for: .normal)
        $0.isUserInteractionEnabled = true
    }

    // MARK: - UIViewController Lyfecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }

}

// MARK: - Private Methods
private extension DraggableModalViewController {
    func addSubviews() {
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(showButton)
        containerStackView.addArrangedSubview(showSecondButton)
        addConstraints()
    }

    func addConstraints() {
        containerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                  left: view.leftAnchor,
                                  paddingLeft: 8,
                                  right: view.rightAnchor,
                                  paddingRight: 8)
    }

    func showModal() {
        ModalTagsFactory.showModalTags(originController: self,
                                       tags: [.init(text: "Text",
                                                    descriptionTag: "Description tag")])
    }

    func showModalWithViewController() {
        let viewController = DynamicHeightCVViewController()
        viewController.view.backgroundColor = .gray
        let component = DraggableModalComponent(controller: viewController,
                                                canBeDismissed: true)
        component.present(over: self)
    }
}

