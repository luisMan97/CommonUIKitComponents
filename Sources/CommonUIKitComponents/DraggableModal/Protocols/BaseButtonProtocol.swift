//
//  BaseButtonProtocol.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

/// Protocol for button Configuration
public protocol BaseButtonProtocol {
    init(config: ButtonConfig)
    func getBaseButton() -> UIView
    func playLoader()
    func setHidden()
    func setEnable()
    func setDisable()
    func buttonTapper() -> Observable<Void>
    func setButtonTitle(_ title: String, state: UIControl.State)
    func setBackgroundColor(_ color: UIColor)
    func setImage(_ image: UIImage, state: UIControl.State, color: UIColor?)
    func setTitleColor(_ color: UIColor, state: UIControl.State)
    func setIconCustomMargen(_ margen: CGFloat)
    func setCustomBorder(_ radius: CGFloat)
}
