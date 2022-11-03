//
//  UITextFieldCustomOTP.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 31/10/22.
//

import UIKit

protocol UITextFieldCustomOTPDelegate: AnyObject {
    /// Recognize backspace key.
    /// - Parameter textField: UITextFieldCustom from which backspace key is captured.
    func deleteBackward(_ textField: UITextFieldCustomOTP)
}

@objc
public class UITextFieldCustomOTP: UITextField {
    
    // MARK: - Private Properties

    weak var isDelegate: UITextFieldCustomOTPDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        textContentType = .oneTimeCode
        textAlignment = .center
        borderStyle = .roundedRect
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Override Methods

    override public func deleteBackward() {
        isDelegate?.deleteBackward(self)
        super.deleteBackward()
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        action == #selector(UIResponderStandardEditActions.copy) ||
        action == #selector(UIResponderStandardEditActions.selectAll) ||
        action == #selector(UIResponderStandardEditActions.paste)
    }

}
