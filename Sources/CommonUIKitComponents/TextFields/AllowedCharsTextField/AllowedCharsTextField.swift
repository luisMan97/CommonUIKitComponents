//
//  AllowedCharsTextField.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 19/11/22.
//

import UIKit

/// - Allows you to define which characters will be accepted in a text field.
/// - Include MaxLengthTextField.
public class AllowedCharsTextField: UITextField {
    
    // MARK: - Public @IBInspectable Properties
    
    /// Set allowed chars using interfaz text field component
    @IBInspectable
    public var allowedCharacters: Characters = .alphanumeric
    
    /// Set allowed chars using interfaz text field component
    @IBInspectable
    public var allowedChars = String()

    /// Set max lenght using interfaz text field component
    @IBInspectable
    public var maxLength: Int {
        get { getMaxLength() }
        set { characterLimit = newValue }
    }
    
    // MARK: - Private Properties

    private var characterLimit: Int?
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        delegate = self
        autocorrectionType = .no
    }
    
    private func getMaxLength() -> Int {
        guard let length = characterLimit else { return Int.max }
        return length
    }
    
}

// MARK: - UITextFieldDelegate
extension AllowedCharsTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text else {
            return false
        }
        if string.isEmpty {
            return true
        }
        let prospectiveText = (textFieldText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= maxLength && prospectiveText.containsOnlyCharactersIn(matchCharacters: allowedChars.isEmpty ? allowedCharacters.stringValue : allowedChars)
    }
    
}
