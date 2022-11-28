//
//  ModalCloseBottomView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

final class ModalCloseBottomView: BaseModalBottomView {

    private lazy var buttonComponent: IntButtonComponent = {
        let frame = CGRect(x: 0, y: 0, width: 48, height: 48)

        let config: ButtonConfig = ButtonConfig(
            buttonColor: .clear,
            iconState: .none,
            initialState: .enable,
            frame: frame,
            size: .square,
            imageColor: .primaryA,
            iconImage: .xmark.withRenderingMode(.alwaysTemplate)
        )

        let component = IntButtonComponent(config: config)
        component.buttonView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(component.buttonView)
        return component
    }()

    var onClose: Observable<Void> {
        return buttonComponent.buttonTapper()
    }

    override func animateAppear(_ appeared: Bool) {
        super.animateAppear(appeared)
        let transform = CGAffineTransform(translationX: 0, y: bounds.height)
        isUserInteractionEnabled = appeared

        UIView.animate(withDuration: appeared ? 0.25 : 0.15, animations: { [weak self] in
            self?.buttonComponent.buttonView.transform = appeared ? .identity : transform
        })
    }

    override func setupView() {
        super.setupView()

        let view = buttonComponent.buttonView
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: .spacing(6)),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.heightAnchor.constraint(equalToConstant: 48.0),
            view.widthAnchor.constraint(equalToConstant: 48.0)
        ])
    }

    override func setupAppearance() {
        super.setupAppearance()
        let buttonView = buttonComponent.buttonView
        isUserInteractionEnabled = false
        gradientView.alpha = 0.0
        buttonComponent.buttonView.transform = CGAffineTransform(translationX: 0,
                                                                 y: 122.0)
        Gradient.accentA(layer: buttonView.layer,
                         direction: .topLeftToBottomRight)
    }
}
