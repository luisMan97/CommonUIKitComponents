//
//  UITextFieldOTPStyles.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 31/10/22.
//

import Foundation

/**
 Styles that can be applied to UITextFields.
 
 ```
 normal: Style by default.
 error: Style to display when the otp is wrong.
 ```
 */
@objc
public enum UITextFieldOTPStyles: Int {
    case normal, error
}
