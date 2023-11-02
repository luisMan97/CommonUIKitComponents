//
//  InteractiveButton.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

final class InteractiveButton: UIView {

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
        animationView = .init(style: .white)
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Internal Methods

    func stopLoader() {
        animationView.stopAnimating()
        button.imageView?.isHidden = false
        button.imageView?.layer.transform = CATransform3DIdentity
        animationView.isHidden = true
        setState(newState: config.state)
    }

    func playLoader() {
        animationView.startAnimating()
        button.imageView?.isHidden = true
        button.imageView?.layer.transform = CATransform3DMakeScale(.zero,
                                                                   .zero,
                                                                   .zero)
        animationView.isHidden = false
    }

    func setState(newState: ButtonState) {
        if config.state == .disabled && newState != .disabled {
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

    func setButtonTitle(_ title: String,
                        state: UIControl.State) {
        button.setTitle(title, for: state)
    }

    func setBackgroundColor(_ color: UIColor) {
        button.backgroundColor = color
    }

    func setImage(_ image: UIImage,
                  state: UIControl.State,
                  color: UIColor? = nil) {
        button.setImage(image.withRenderingMode(.automatic), for: state)
        button.imageView?.tintColor = color ?? .white
    }

    func setTitleColor(_ color: UIColor,
                       state: UIControl.State) {
        button.setTitleColor(color, for: state)
    }

    func setImageColor(_ color: UIColor) {
        button.setImage(config.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(config.image?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        button.tintColor = color
        button.imageView?.tintColor = color
    }

    func setIconCustomMargen(_ margen: CGFloat) {
        button.imageView?.leadingAnchor.constraint(lessThanOrEqualTo: button.leadingAnchor,
                                                        constant: margen ).isActive = true
        button.imageView?.topAnchor.constraint(lessThanOrEqualTo: button.topAnchor,
                                                    constant: margen ).isActive = true
        button.imageView?.contentMode = .scaleToFill
    }

    func setCustomBorder(_ radius: CGFloat) {
        button.setupRoundedCorners(radius: radius)
    }

    func setGradientColors(_ colors: [UIColor]) {
        Gradient.setGradient(in: button.layer,
                             colors: colors,
                             direction: .bottom)
    }
}

// MARK: - Private Methods
private extension InteractiveButton {
    func setupUI() {
        setButton()
        setIcon()
        setConstraints()
        if config.state == .disabled {
            setDisableButton()
        }
    }

    func setButton() {
        button.addTargetAction(for: .touchUpInside) { [weak self] in
            guard let self else { return }
            buttonTapMutableObservable.postValue(())
            hapticFeedbackIfEnabled(config: config)
        }
        button.backgroundColor = config.backgroundColor
        switch config.size {
        case .circular:
            setupBorder(color: config.border ?? .clear)
            setupRoundedCorners(radius: config.width * 44 / 90)
        case .square:
            setupBorder(color: config.border ?? .clear)
            setupRoundedCorners(radius: config.height * 1 / 3)
        default:
            break
        }
        switch config.state {
        case .hidden:
            isHidden = true
        default:
            break
        }
    }

    func setIcon() {
        button.setImage(config.image, for: .normal)
        button.setImage(config.image, for: .highlighted)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = config.imageColor ?? .white
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        button.imageView?.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
    }

    func setConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.topAnchor.constraint(lessThanOrEqualTo: topAnchor).isActive = true
        button.leadingAnchor.constraint(lessThanOrEqualTo: leadingAnchor).isActive = true
        button.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor).isActive = true
        button.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: config.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: config.width).isActive = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(animationView)
        animationView.centerXAnchor.constraint(lessThanOrEqualTo: centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(lessThanOrEqualTo: centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor,
                                              multiplier: 1).isActive = true
        animationView.widthAnchor.constraint(lessThanOrEqualTo: heightAnchor,
                                             multiplier: 1).isActive = true
    }

    func setEnableButton() {
        button.isEnabled = true
        button.backgroundColor = config.backgroundColor
        button.imageView?.tintColor = config.imageColor
    }

    func setDisableButton() {
        button.isEnabled = false
        button.backgroundColor = .lightGray
        button.imageView?.tintColor = .white
    }
}
