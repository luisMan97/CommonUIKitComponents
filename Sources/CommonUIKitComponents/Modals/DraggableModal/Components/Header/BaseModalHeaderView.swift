//
//  BaseModalHeaderView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

class BaseModalHeaderView: UIView {

    private lazy var decoratorView = UIView(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        addSubview($0)
    }

    private lazy var scaleFactor: CGFloat = {
        let screenSize = UIScreen.main.bounds
        let insets = config.contentInsets.left + config.contentInsets.right
        let factor = (screenSize.width - insets) / screenSize.width
        return factor
    }()

    var isFloating: Bool { config.isFloating }

    private let config: BaseModalHeaderConfig

    enum ModalTitleHeaderState {
        case modal, fullscreen
    }

    init(frame: CGRect, config: BaseModalHeaderConfig) {
        self.config = config
        super.init(frame: frame)
        decoratorView.isHidden = !config.showDecorator
        setupConstraints()
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    final func setup(state: ModalTitleHeaderState) {
        guard config.title != nil else { return }
        switch state {
        case .modal:
            decoratorView.transform = CGAffineTransform(scaleX: scaleFactor, y: 1)
        default:
            decoratorView.transform = .identity
        }
    }

    func collectionDidScroll(_ collectionOffset: CGPoint?) {
        guard let collectionOffset = collectionOffset else { return }

        if let offsetToDisplay = config.offsetToDisplay {
            isHidden = collectionOffset.y <= offsetToDisplay
        }
    }

    func calculateAppropriateHeight() -> CGFloat {
        return 0
    }

    func titleTapper() -> Observable<Void>? {
        return nil
    }
}

private extension BaseModalHeaderView {

    func setupConstraints() {
        NSLayoutConstraint.activate([
            decoratorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            decoratorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            decoratorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            decoratorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func setupAppearance() {
        isHidden = config.isHidden
        backgroundColor = .primaryA
        let radius: CGFloat = config.isFloating ? 0 : 30.0
        setupRoundedCorners(radius: radius, corners: [.topLeft, .topRight])

        decoratorView.backgroundColor = config.decoratorColor ?? .borderOpaque
        decoratorView.transform = CGAffineTransform(scaleX: scaleFactor,
                                                    y: 1)
    }

}

