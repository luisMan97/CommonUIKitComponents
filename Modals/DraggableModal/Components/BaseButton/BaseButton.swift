//
//  BaseButton.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/11/22.
//

import UIKit

internal final class BaseButton: UIView {
    private var animationView: UIActivityIndicatorView
    private var button: UIButton
    private var config: ButtonConfig
    private var iconView: UIImageView?
    
    private func setButton() {
        self.button.addTargetAction(for: .touchUpInside) { [weak self] in
            guard let self = self else { return }
            self.buttonTapMutableObservable.postValue(())
            self.hapticFeedbackIfEnabled(config: self.config)
        }
        self.button.setTitle(config.titleString, for: .normal)
        self.button.titleLabel?.font = config.titlefont
        self.button.setTitleColor(config.titleColor, for: .normal)
        self.button.backgroundColor = config.backgroundColor
        switch config.size {
        case .small:
            self.button.setupRoundedCorners(radius: 18, smoothCorners: false)
        case .large:
            self.button.setupRoundedCorners(radius: 30, smoothCorners: false)
        case .medium:
            self.button.setupRoundedCorners(radius: 25, smoothCorners: false)
        default:
            break
        }
        self.button.setupBorder(color: config.border ?? .borderTransparent)
        switch config.state {
        case .hidden:
            self.isHidden = true
        default:
            break
        }
    }

    private func setIcon() {
        self.button.setImage(config.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.button.imageView?.contentMode = .scaleAspectFit
        self.button.imageView?.tintColor = config.imageColor
        self.button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.button.imageView?.leadingAnchor.constraint(equalTo: self.button.leadingAnchor, constant: 18).isActive = true
        self.button.imageView?.centerYAnchor.constraint(equalTo: self.button.centerYAnchor).isActive = true
        self.button.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.button.titleLabel?.centerXAnchor.constraint(equalTo: self.button.centerXAnchor).isActive = true
        self.button.titleLabel?.centerYAnchor.constraint(equalTo: self.button.centerYAnchor).isActive = true
        self.button.titleLabel?.textAlignment = .center
    }

    init(config: ButtonConfig) {
        self.config = config
        button = UIButton()
        if config.backgroundColor == .primaryA {
            animationView = UIActivityIndicatorView(style: .gray)
        } else {
            animationView = UIActivityIndicatorView(style: .white)
        }
        super.init(frame: CGRect(x: 0, y: 0, width: config.width, height: config.height))
        setupUI()
    }

    required init?(coder: NSCoder) {
        self.config = ButtonConfig()
        button = UIButton()
        animationView = UIActivityIndicatorView(style: .gray)
        super.init(coder: coder)
        setupUI()
    }

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

    private func setConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: config.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: config.width).isActive = true
        animationView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(animationView)
        animationView.centerXAnchor.constraint(lessThanOrEqualTo: self.button.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(lessThanOrEqualTo: self.button.centerYAnchor).isActive = true
        animationView.heightAnchor.constraint(lessThanOrEqualTo: self.button.heightAnchor, multiplier: 1).isActive = true
        animationView.widthAnchor.constraint(lessThanOrEqualTo: self.button.heightAnchor, multiplier: 1).isActive = true
    }

    func stopLoader() {
        self.button.setTitle(config.titleString, for: .normal)
        self.animationView.stopAnimating()
        self.animationView.isHidden = true
        self.setState(newState: config.state)
    }

    func playLoader() {
        self.button.setTitle("", for: .normal)
        self.animationView.startAnimating()
        self.animationView.isHidden = false
    }

    func setState(newState: ButtonState) {
        if self.animationView.isAnimating {
            self.animationView.stopAnimating()
        }
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
        self.button.setTitleColor(.primaryA, for: .disabled)
        if config.imageAlignment != .none {
            self.button.imageView?.tintColor = .primaryA
        }
    }

    private func setEnableButton() {
        self.button.isEnabled = true
        self.button.backgroundColor = config.backgroundColor
        self.button.setTitleColor(config.titleColor, for: .disabled)
        if config.imageAlignment != .none {
            self.button.imageView?.tintColor = config.imageColor
        }
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
        self.button.setImage(image.withRenderingMode(.alwaysTemplate), for: state)
        self.button.imageView?.tintColor = color
    }

    func setTitleColor(_ color: UIColor, state: UIControl.State) {
        self.button.setTitleColor(color, for: state)
    }

    func setIconCustomMargen(_ margen: CGFloat) {
        self.button.imageView?.leadingAnchor.constraint(lessThanOrEqualTo: self.button.leadingAnchor,
                                                        constant: margen ).isActive = true
        self.button.imageView?.topAnchor.constraint(lessThanOrEqualTo: self.button.topAnchor,
                                                    constant: margen ).isActive = true
        self.button.imageView?.contentMode = .scaleToFill
    }

    func setCustomBorder(_ radius: CGFloat) {
        self.button.setupRoundedCorners(radius: radius, smoothCorners: false)
    }
}
