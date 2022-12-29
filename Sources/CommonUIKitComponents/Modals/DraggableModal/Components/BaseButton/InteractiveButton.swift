//
//  InteractiveButton.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

internal final class InteractiveButton: UIView {

    private var animationView: UIActivityIndicatorView
    private var button: UIButton
    private var config: ButtonConfig

    init(config: ButtonConfig) {
        self.config = config
        button = UIButton()
        if config.backgroundColor == .primaryA {
            animationView = UIActivityIndicatorView(style: .gray)
        } else {
            animationView = UIActivityIndicatorView(style: .white)
        }
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: config.width,
                                 height: config.height))
        setupUI()
    }

    required init?(coder: NSCoder) {
        button = UIButton()
        animationView = UIActivityIndicatorView(style: .white)
        config = ButtonConfig()
        super.init(coder: coder)
        setupUI()
    }

    private func setButton() {
        button.addTargetAction(for: .touchUpInside) {
            self.buttonTapMutableObservable.postValue(())
            self.hapticFeedbackIfEnabled(config: self.config)
        }
        self.button.backgroundColor = config.backgroundColor
        switch config.size {
        case .circular:
            self.setupBorder(color: config.border ?? .clear)
            self.setupRoundedCorners(radius: config.width * 44 / 90)
        case .square:
            self.setupBorder(color: config.border ?? .clear)
            self.setupRoundedCorners(radius: config.height * 1 / 3)
        default:
            break
        }
        switch config.state {
        case .hidden:
            self.isHidden = true
        default:
            break
        }
    }

    private func setIcon() {
        self.button.setImage(config.image, for: .normal)
        self.button.setImage(config.image, for: .highlighted)
        self.button.imageView?.contentMode = .scaleAspectFit
        self.button.imageView?.tintColor = config.imageColor ?? .primaryA
        self.button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.button.imageView?.centerYAnchor.constraint(equalTo: self.button.centerYAnchor).isActive = true
        self.button.imageView?.centerXAnchor.constraint(equalTo: self.button.centerXAnchor).isActive = true
    }

    private func setupUI() {
        setButton()
        setIcon()
        setConstraints()
    }

    private func setConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        button.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor).isActive = true
        button.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor).isActive = true
        button.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        button.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: config.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: config.width).isActive = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        animationView.centerXAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1).isActive = true
        animationView.widthAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1).isActive = true
    }

    func stopLoader() {
        self.animationView.stopAnimating()
        self.button.imageView?.isHidden = false
        self.button.imageView?.layer.transform = CATransform3DIdentity
        self.animationView.isHidden = true
        self.setState(newState: config.state)
    }

    func playLoader() {
        self.animationView.startAnimating()
        self.button.imageView?.isHidden = true
        self.button.imageView?.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
        self.animationView.isHidden = false
    }

    func setState(newState: ButtonState) {
        if self.config.state  == .disabled && newState != .disabled {
            self.setEnableButton()
        }
        switch newState {
        case .enable:
            self.isHidden = false
        case .hidden:
            self.isHidden = true
        case .disabled:
            self.setDisableButton()
        }
        self.config.state = newState
    }

    private func setDisableButton() {
        self.button.isEnabled = false
        self.button.backgroundColor = .contentC
        self.button.imageView?.tintColor = .primaryA
    }

    private func setEnableButton() {
        self.button.isEnabled = true
        self.button.backgroundColor = config.backgroundColor
        self.button.imageView?.tintColor = config.imageColor
    }

    var buttonTap: Observable<Void> {
        buttonTapMutableObservable
    }
    
    private let buttonTapMutableObservable = MutableObservable<Void>()

    func setButtonTitle(_ title: String, state: UIControl.State) {
        self.button.setTitle(title, for: state)
    }

    func setBackgroundColor(_ color: UIColor) {
        self.button.backgroundColor = color
    }

    func setImage(_ image: UIImage, state: UIControl.State, color: UIColor? = nil) {
        self.button.setImage(image.withRenderingMode(.automatic), for: state)
        self.button.imageView?.tintColor = color ?? .primaryA
    }

    func setTitleColor(_ color: UIColor, state: UIControl.State) {
        self.button.setTitleColor(color, for: state)
    }

    func setImageColor(_ color: UIColor) {
        self.button.setImage(config.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.button.setImage(config.image?.withRenderingMode(.alwaysTemplate), for: .highlighted)
        self.button.tintColor = color
        self.button.imageView?.tintColor = color
    }

    func setIconCustomMargen(_ margen: CGFloat) {
        self.button.imageView?.leadingAnchor.constraint(lessThanOrEqualTo: self.button.leadingAnchor,
                                                        constant: margen ).isActive = true
        self.button.imageView?.topAnchor.constraint(lessThanOrEqualTo: self.button.topAnchor,
                                                    constant: margen ).isActive = true
        self.button.imageView?.contentMode = .scaleToFill
    }

    func setCustomBorder(_ radius: CGFloat) {
        self.button.setupRoundedCorners(radius: radius)
    }

    func setGradientColors(_ colors: [UIColor]) {
        Gradient.setGradient(in: button.layer,
                             colors: colors,
                             direction: .bottom)
    }
}
