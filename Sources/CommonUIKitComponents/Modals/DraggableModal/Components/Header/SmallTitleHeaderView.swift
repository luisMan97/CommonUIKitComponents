//
//  SmallTitleHeaderView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

class SmallTitleHeaderView: BaseModalHeaderView {

    private lazy var titleLabel = UILabel(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        $0.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private lazy var titleRightIcon = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var titleButton = UIButton().then {
        $0.addTargetAction(for: .touchUpInside) {
            self.titleTapperMutableObservable.postValue(())
        }
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var containerTitleView = UIView(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addSubview(titleButton)
        $0.addSubview(titleLabel)
        $0.addSubview(titleRightIcon)
        addSubview($0)
    }

    private lazy var rightButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = .spacing(2)
        addSubview($0)
    }

    private lazy var leftButtonsStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = .spacing(2)
        addSubview($0)
    }

    private let config: BaseModalHeaderConfig
    
    private let titleTapperMutableObservable: MutableObservable = MutableObservable<Void>()

    override init(frame: CGRect, config: BaseModalHeaderConfig) {
        self.config = config
        super.init(frame: frame, config: config)
        setupConstraints()
        setupRightButtons()
        setupLeftButtons()
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override final func calculateAppropriateHeight() -> CGFloat {
        var height: CGFloat = config.contentInsets.bottom + config.contentInsets.top

        height += max(titleLabel.intrinsicContentSize.height,
                      rightButtonsStackView.frame.height,
                      leftButtonsStackView.frame.height)

        return height
    }

    override func titleTapper() -> Observable<Void>? {
        titleTapperMutableObservable
    }
}

private extension SmallTitleHeaderView {

    func setupConstraints() {

        NSLayoutConstraint.activate([
            leftButtonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: config.contentInsets.left),
            leftButtonsStackView.centerYAnchor.constraint(equalTo: containerTitleView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            rightButtonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -config.contentInsets.right),
            rightButtonsStackView.centerYAnchor.constraint(equalTo: containerTitleView.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            titleRightIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleRightIcon.trailingAnchor.constraint(equalTo: containerTitleView.trailingAnchor),
            titleRightIcon.topAnchor.constraint(greaterThanOrEqualTo: containerTitleView.topAnchor),
            titleRightIcon.bottomAnchor.constraint(lessThanOrEqualTo: containerTitleView.bottomAnchor),
            titleRightIcon.heightAnchor.constraint(equalToConstant: .spacing(6)),
            titleRightIcon.widthAnchor.constraint(equalToConstant: config.titleRightIcon != nil ? .spacing(6) : 0),
            titleRightIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerTitleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleRightIcon.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: containerTitleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerTitleView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            titleButton.leadingAnchor.constraint(equalTo: containerTitleView.leadingAnchor),
            titleButton.trailingAnchor.constraint(equalTo: containerTitleView.trailingAnchor),
            titleButton.topAnchor.constraint(equalTo: containerTitleView.topAnchor),
            titleButton.bottomAnchor.constraint(equalTo: containerTitleView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            containerTitleView.leadingAnchor.constraint(greaterThanOrEqualTo: leftButtonsStackView.trailingAnchor, constant: .spacing(1)),
            containerTitleView.trailingAnchor.constraint(lessThanOrEqualTo: rightButtonsStackView.leadingAnchor, constant: -.spacing(1)),
            containerTitleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerTitleView.topAnchor.constraint(equalTo: topAnchor, constant: config.contentInsets.top),
            containerTitleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -config.contentInsets.bottom)
        ])
    }

    func setupAppearance() {
        backgroundColor = .white
        let radius: CGFloat = config.isFloating ? 0 : 30.0
        setupRoundedCorners(radius: radius, corners: [.topLeft, .topRight])

        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.attributedText = config.title
        titleRightIcon.image = config.titleRightIcon
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

    private func setupLeftButtons() {
        guard let leadingButtons = config.leadingButtons else { return }

        for baseButton in leadingButtons {
            let button = baseButton.getBaseButton()
            leftButtonsStackView.addArrangedSubview(button)

            let width = min(button.frame.width, .spacing(15))
            let height = min(button.frame.height, .spacing(10))

            button.widthAnchor.constraint(equalToConstant: width).isActive = true
            button.heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        leftButtonsStackView.layoutIfNeeded()
    }
}
