//
//  BaseButton.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/11/22.
//

import UIKit

final class BaseButton: UIView {

    // MARK: - Private UI Properties

    private var animationView: UIActivityIndicatorView
    private var button: UIButton
    private var config: ButtonConfig

    // MARK: - Internal Properties

    var buttonTap: Observable<Void> { buttonTapMutableObservable }

    // MARK: - Private Properties

    private let buttonTapMutableObservable = MutableObservable<Void>()

    // MARK: - Initializers

    init(config: ButtonConfig) {
        self.config = config
        button = UIButton()
        animationView = .init(style: config.backgroundColor == .white ? .gray : .white)
        super.init(frame: CGRect(x: .zero,
                                 y: .zero,
                                 width: config.width,
                                 height: config.height))
        setupUI()
    }

    required init?(coder: NSCoder) {
        config = ButtonConfig()
        button = UIButton()
        animationView = .init(style: .gray)
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Internal Methods

    func stopLoader() {
        button.setTitle(config.titleString, for: .normal)
        animationView.stopAnimating()
        animationView.isHidden = true
        setState(newState: config.state)
    }

    func playLoader() {
        button.setTitle("", for: .normal)
        animationView.startAnimating()
        animationView.isHidden = false
    }

    func setState(newState: ButtonState) {
        if animationView.isAnimating {
            animationView.stopAnimating()
        }
        if config.state  == .disabled && newState != .disabled {
            setEnableButton()
        }
        switch newState {
        case .enable:
            isHidden = false
        case .hidden:
            isHidden = true
        case .disabled:
            setDisableButton()
        }
        config.state = newState
    }

    func setButtonTitle(_ title: String, state: UIControl.State) {
        button.setTitle(title, for: state)
    }

    func setBackgroundColor(_ color: UIColor) {
        button.backgroundColor = color
    }

    func setImage(_ image: UIImage, state: UIControl.State, color: UIColor? = nil) {
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: state)
        button.imageView?.tintColor = color
    }

    func setTitleColor(_ color: UIColor, state: UIControl.State) {
        button.setTitleColor(color, for: state)
    }

    func setIconCustomMargen(_ margen: CGFloat) {
        button.imageView?.leadingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor,
                                                   constant: margen).isActive = true
        button.imageView?.topAnchor.constraint(lessThanOrEqualTo: button.topAnchor,
                                               constant: margen).isActive = true
        button.imageView?.contentMode = .scaleToFill
    }

    func setCustomBorder(_ radius: CGFloat) {
        button.setupRoundedCorners(radius: radius,
                                   smoothCorners: false)
    }
}

// MARK: - Private Methods
private extension BaseButton {
    private func setupUI() {
        setButton()
        switch config.imageAlignment {
        case .left:
            setIcon()
        default:
            break
        }
        setConstraints()
        if config.state == .disabled {
            setDisableButton()
        }
    }

    private func setButton() {
        button.addTargetAction(for: .touchUpInside) { [weak self] in
            guard let self else { return }
            buttonTapMutableObservable.postValue(())
            hapticFeedbackIfEnabled(config: config)
        }
        button.setTitle(config.titleString, for: .normal)
        button.titleLabel?.font = config.titlefont
        button.setTitleColor(config.titleColor, for: .normal)
        button.backgroundColor = config.backgroundColor
        switch config.size {
        case .small:
            button.setupRoundedCorners(radius: 18,
                                       smoothCorners: false)
        case .large:
            button.setupRoundedCorners(radius: 30,
                                       smoothCorners: false)
        case .medium:
            button.setupRoundedCorners(radius: 25,
                                       smoothCorners: false)
        default:
            break
        }
        button.setupBorder(color: config.border ?? .borderTransparent)
        switch config.state {
        case .hidden:
            isHidden = true
        default:
            break
        }
    }

    private func setIcon() {
        button.setImage(config.image?.withRenderingMode(.alwaysTemplate),
                        for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = config.imageColor
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.leadingAnchor.constraint(equalTo: button.leadingAnchor,
                                                   constant: 18).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        button.titleLabel?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.titleLabel?.textAlignment = .center
    }

    private func setConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: config.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: config.width).isActive = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)
        animationView.centerXAnchor.constraint(lessThanOrEqualTo: button.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(lessThanOrEqualTo: button.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(lessThanOrEqualTo: button.heightAnchor,
                                              multiplier: 1).isActive = true
        animationView.widthAnchor.constraint(lessThanOrEqualTo: button.heightAnchor,
                                             multiplier: 1).isActive = true
    }

    private func setEnableButton() {
        button.isEnabled = true
        button.backgroundColor = config.backgroundColor
        button.setTitleColor(config.titleColor, for: .disabled)
        if config.imageAlignment != .none {
            button.imageView?.tintColor = config.imageColor
        }
    }

    private func setDisableButton() {
        button.isEnabled = false
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .disabled)
        if config.imageAlignment != .none {
            button.imageView?.tintColor = .white
        }
    }
}
