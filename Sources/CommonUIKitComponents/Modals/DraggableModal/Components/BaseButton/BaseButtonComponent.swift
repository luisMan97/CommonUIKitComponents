//
//  BaseButtonComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/11/22.
//

import UIKit

public final class BaseButtonComponent: BaseButtonProtocol {

    private var componentButton: BaseButton

    public var buttonView: UIView { componentButton }

    public init(config: ButtonConfig) {
        componentButton = BaseButton(config: config)
    }

    public func getBaseButton() -> UIView { componentButton }

    public func playLoader() {
        componentButton.playLoader()
    }

    public func stopLoader() {
        componentButton.stopLoader()
    }

    public func setHidden() {
        componentButton.setState(newState: .hidden)
    }

    public func setEnable() {
        componentButton.setState(newState: .enable)
    }

    public func buttonTapper() -> Observable<Void> { componentButton.buttonTap }

    public func setDisable() {
        componentButton.setState(newState: .disabled)
    }

    public func setButtonTitle(_ title: String,
                               state: UIControl.State) {
        componentButton.setButtonTitle(title,
                                       state: state)
    }

    public func setBackgroundColor(_ color: UIColor) {
        componentButton.setBackgroundColor(color)
    }

    public func setImage(_ image: UIImage,
                         state: UIControl.State,
                         color: UIColor? = nil) {
        componentButton.setImage(image,
                                 state: state,
                                 color: color)
    }

    public func setTitleColor(_ color: UIColor,
                              state: UIControl.State) {
        componentButton.setTitleColor(color,
                                      state: state)
    }

    public func setIconCustomMargen(_ margen: CGFloat) {
        componentButton.setIconCustomMargen(margen)
    }

    public func setCustomBorder(_ radius: CGFloat) {
        componentButton.setCustomBorder(radius)
    }
}
