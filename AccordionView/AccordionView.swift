//
//  AccordionView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 24/02/23.
//

import UIKit

enum Arrow: String {
    case up, down
}

public class AccordionView: BaseUIView {

    // MARK: - Private UI Properties

    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }

    private lazy var headerButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.alignImageRight()
        $0.setImage(.chevronDown.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.addTargetAction(for: .touchUpInside) { [weak self] in
            self?.selectAction()
        }
    }

    private let bodyView = UIView().then {
        $0.isHidden = true
    }

    // MARK: - Public Properties

    public var headerTitle = String() {
        didSet { headerButton.setTitle(headerTitle, for: .normal) }
    }

    // MARK: - Public Methods

    public func addContentView(_ view: UIView) {
        view.fixInView(bodyView)
    }

    public override func configureView() {
        super.configureView()
        addSubViews()
    }

    // MARK: - Private Methods

    private func addSubViews() {
        contentStackView.fixInView(self)

        contentStackView.addArrangedSubview(headerButton)
        contentStackView.addArrangedSubview(bodyView)

        addConstraints()
    }

    private func addConstraints() {
        headerButton.anchor(height: 30)
    }

    private func selectAction() {
        configure(expand: bodyView.isHidden)
        bodyView.isHidden.toggle()
    }

    private func configure(expand: Bool) {
        if expand {
            self.expand(animated: true)
        } else {
            collapse(animated: true)
        }
    }

    private func expand(animated: Bool) {
        update(arrow: .up, animated: animated)
    }

    private func collapse(animated: Bool) {
        update(arrow: .down, animated: animated)
    }

    private func update(arrow: Arrow, animated: Bool) {
        switch arrow {
        case .up:
            if animated {
                headerButton.imageView?.rotate(withAngle: 0, animated: false)
                headerButton.imageView?.rotate(withAngle: .pi, animated: true)
            } else {
                headerButton.imageView?.rotate(withAngle: .pi, animated: false)
            }
        case .down:
            if animated {
                headerButton.imageView?.rotate(withAngle: .pi, animated: false)
                headerButton.imageView?.rotate(withAngle: 0, animated: true)
            } else {
                headerButton.imageView?.rotate(withAngle: 0, animated: false)
            }
        }
    }

}
