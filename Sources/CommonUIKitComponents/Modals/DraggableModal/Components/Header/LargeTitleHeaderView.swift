//
//  LargeTitleHeaderView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

final class LargeTitleHeaderView: BaseModalHeaderView {

    private lazy var titleLabel = UILabel(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.sizeToFit()
        addSubview($0)
    }

    private lazy var subtitleLabel = UILabel(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.sizeToFit()
        addSubview($0)
    }

    private lazy var toptitleLabel = UILabel(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.sizeToFit()
        addSubview($0)
    }

    private lazy var rightButtonsStackView = UIStackView().then {
        $0.axis = NSLayoutConstraint.Axis.horizontal
        $0.distribution = UIStackView.Distribution.fill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = .spacing(2)
        addSubview($0)
    }

    private let config: BaseModalHeaderConfig

    override init(frame: CGRect, config: BaseModalHeaderConfig) {
        self.config = config
        super.init(frame: frame, config: config)
        setupConstraints()
        setupRightButtons()
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override final func calculateAppropriateHeight() -> CGFloat {
        var height: CGFloat = config.contentInsets.bottom + config.contentInsets.top
        let toptitleHeight = toptitleLabel.intrinsicContentSize.height
        let titleHeight = titleLabel.intrinsicContentSize.height
        let subtitleHeight = subtitleLabel.intrinsicContentSize.height
        let labelsHeight = toptitleHeight + titleHeight + subtitleHeight
        let rightButtonsHeight = rightButtonsStackView.frame.height

        height += max(labelsHeight, rightButtonsHeight)

        return height
    }
}

private extension LargeTitleHeaderView {

    func setupConstraints() {

        NSLayoutConstraint.activate([
            rightButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -config.contentInsets.right),
            rightButtonsStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            toptitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.contentInsets.left),
            toptitleLabel.trailingAnchor.constraint(equalTo: rightButtonsStackView.leadingAnchor, constant: -.spacing(1)),
            toptitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: config.contentInsets.top)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.contentInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: rightButtonsStackView.leadingAnchor, constant: -.spacing(1)),
            titleLabel.topAnchor.constraint(equalTo: toptitleLabel.bottomAnchor, constant: config.spaceToTopTitle ?? 0)
        ])

        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.contentInsets.left),
            subtitleLabel.trailingAnchor.constraint(equalTo: rightButtonsStackView.leadingAnchor, constant: -.spacing(1)),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -config.contentInsets.bottom)
        ])
    }

    func setupAppearance() {
        backgroundColor = .primaryA
        let radius: CGFloat = config.isFloating ? 0 : 30.0
        setupRoundedCorners(radius: radius, corners: [.topLeft, .topRight])

        titleLabel.numberOfLines = 1
        titleLabel.attributedText = config.title

        subtitleLabel.numberOfLines = 1
        subtitleLabel.attributedText = config.subtitle

        toptitleLabel.numberOfLines = 1
        toptitleLabel.attributedText = config.toptitle
    }

    private func setupRightButtons() {
        guard let trailingButtons = config.trailingButtons else { return }

        for baseButton in trailingButtons {
            let button = baseButton.getBaseButton()
            rightButtonsStackView.addArrangedSubview(button)

            let width = min(button.frame.width, .spacing(15))
            let height = min(button.frame.height, .spacing(10))

            button.widthAnchor.constraint(equalToConstant: width).isActive = true
            button.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        rightButtonsStackView.layoutIfNeeded()
    }
}

