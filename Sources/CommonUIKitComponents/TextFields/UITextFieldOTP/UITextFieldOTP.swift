//
//  UITextFieldOTP.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 31/10/22.
//

import UIKit

@objc
public protocol UITextFieldOTPDelegate: AnyObject {
    /// This function can be used to validate that all UITextFields were completed.
    /// - Parameters:
    ///   - uiTextFieldOTP: UITextFieldOTP that receives the events.
    ///   - isValid: True if the UITextFields were completed, false otherwise.
    func textFieldOTP(_ textFieldOTP: UITextFieldOTP, isValid: Bool)
}

/// The purpose of UITextFieldOTP is to provide an interface with dynamic UITextFields to enter any type of numeric code.
@objc
public class UITextFieldOTP: UIView {

    typealias Layout = OTPLayout

    // MARK: - Private UI Properties

    private lazy var hidenKeyboardButton = UIButton().then {
        $0.isHidden = false
        $0.addTarget(self, action: #selector(showKeyboard), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let containerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 10.0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    // MARK: - Public Properties

    @objc
    public var textFields: [UITextFieldCustomOTP] = []

    @objc
    public weak var delegate: UITextFieldOTPDelegate?

    @objc
    public var keyboardType: UIKeyboardType = .numberPad

    @objc
    public var style: UITextFieldOTPStyles = .normal {
        didSet { if style != oldValue { otpStyle(style) } }
    }

    @objc
    public var hideKeyboardAutomatically: Bool = false

    // MARK: - Public @IBInspectable Properties

    @IBInspectable
    public var numberOfTextFields: Int = 0 {
        didSet { setupNumberOfTextFields() }
    }
    @IBInspectable
    public var spacing: CGFloat = Layout.spacing {
        didSet { containerStackView.spacing = spacing }
    }
    @IBInspectable
    public var selectorColor: UIColor = .blue
    @IBInspectable
    public var font: String = defaultFont
    @IBInspectable
    public var fontSize: CGFloat = Layout.fontSize
    @IBInspectable
    public var textColor: UIColor = #colorLiteral(red: 0.3607843137, green: 0.3803921569, blue: 0.4, alpha: 1)
    @IBInspectable
    public var textFieldBackgroundColor: UIColor = .white {
        didSet { setupTextFieldBackgroundColor() }
    }
    @IBInspectable
    public var borderStyle: UITextField.BorderStyle = .none
    @IBInspectable
    public var borderWidth: CGFloat = 1.0
    @IBInspectable
    public var borderColor: UIColor = .gray
    @IBInspectable
    public var addCornerRadius: CGFloat = Layout.cornerRadius
    @IBInspectable
    public var errorSelectorColor: UIColor = .blue
    @IBInspectable
    public var errorFont: String = defaultFont
    @IBInspectable
    public var errorFontSize: CGFloat = Layout.fontSize
    @IBInspectable
    public var errorTextColor: UIColor = #colorLiteral(red: 0.3607843137, green: 0.3803921569, blue: 0.4, alpha: 1)
    @IBInspectable
    public var errorTextFieldBackgroundColor: UIColor = .red.withAlphaComponent(0.1)
    @IBInspectable
    public var errorBorderStyle: UITextField.BorderStyle = .none
    @IBInspectable
    public var errorBorderWidth: CGFloat = 1.0
    @IBInspectable
    public var errorBorderColor: UIColor = .red
    @IBInspectable
    public var errorCornerRadius: CGFloat = Layout.cornerRadius
    @IBInspectable
    public var isSecureTextEntry: Bool = false

    // MARK: - Private Methods

    private static let defaultFont = "PFBeauSansPro-Regular"
    private let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left],
                accessibilityIdentifierOTPTextField = "otpTextField"
    private var arrayOTP: [String] = []
    private var awakeFromNibWasCalled = false
    private var currentIndex: Int { arrayOTP.firstIndex(of: String()) ?? arrayOTP.count - 1 }

    // MARK: - Override Methods

    override public func awakeFromNib() {
        super.awakeFromNib()
        awakeFromNibWasCalled = true
        setup()
    }

    deinit {
        unRegisterNotifications()
    }

    // MARK: - Public Methods

    @objc
    public func setupWhenBuildingUIProgrammatically() {
        if awakeFromNibWasCalled { return }
        setup()
    }

    @objc
    public func setNewDigit(_ digit: String) {
        setDigit(digit, atIndex: currentIndex)
    }

    @objc
    public func removeLastDigit() {
        var index = currentIndex
        if arrayOTP.firstIndex(of: String()) != nil {
            index -= 1
        }
        setDigit(String(), atIndex: index)
    }

    /// This function join all the values of the UITextFields and returns a string.
    /// - Returns: OTP.
    @objc
    public func getOTP() -> String { arrayOTP.joined() }

    /// This function remove all the values of the UITextFields.
    @objc
    public func removeOTP() {
        arrayOTP.removeAll(keepingCapacity: true)
        textFields.forEach {
            $0.text?.removeAll(keepingCapacity: true)
            arrayOTP.append(String())
            $0.endEditing(true)
        }
    }

    /// Change the style of the UITextFieldOTP.
    /// - Parameter style: Normal or Error.
    @objc
    public func otpStyle(_ style: UITextFieldOTPStyles) {
        self.style = style
        switch style {
        case .normal:
            addStyleToUITextFields(selectorColor: selectorColor,
                                   font: font,
                                   fontSize: fontSize,
                                   textColor: textColor,
                                   backgroundColor: textFieldBackgroundColor,
                                   borderStyle: borderStyle,
                                   borderWidth: borderWidth,
                                   borderColor: borderColor,
                cornerRadius: addCornerRadius)
        case .error:
            addStyleToUITextFields(selectorColor: errorSelectorColor,
                                   font: errorFont,
                                   fontSize: errorFontSize,
                                   textColor: errorTextColor,
                                   backgroundColor: errorTextFieldBackgroundColor,
                                   borderStyle: errorBorderStyle,
                                   borderWidth: errorBorderWidth,
                                   borderColor: errorBorderColor,
                                   cornerRadius: errorCornerRadius)
        }
    }

    // MARK: - Private Methods

    private func setup() {
        otpStyle(style)
        addSubViews()
        registerNotifications()
    }

    private func addSubViews() {
        addSubview(containerStackView)
        addSubview(hidenKeyboardButton)
        addConstraints()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate(
            layoutAttributes.map {
                NSLayoutConstraint(item: containerStackView,
                                   attribute: $0,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: $0,
                                   multiplier: 1.0,
                                   constant: 0.0)
            }
        )

        NSLayoutConstraint.activate(
            layoutAttributes.map {
                NSLayoutConstraint(item: hidenKeyboardButton,
                                   attribute: $0,
                                   relatedBy: .equal,
                                   toItem: self,
                                   attribute: $0,
                                   multiplier: 1.0,
                                   constant: 0.0)
            }
        )
    }

    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func unRegisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func setupTextFieldBackgroundColor() {
        guard style == .normal else { return }
        textFields.forEach { $0.backgroundColor = textFieldBackgroundColor }
    }

    private func setupNumberOfTextFields() {
        guard numberOfTextFields > 0 else { return }
        clearAll()
        for index in 1...numberOfTextFields {
            let textField = UITextFieldCustomOTP()
            textField.isAccessibilityElement = true
            textField.accessibilityIdentifier = accessibilityIdentifierOTPTextField.appending("_").appending(String(index))
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
            textField.otpDelegate = self
            textField.tag = index
            textField.delegate = self
            textField.keyboardType = keyboardType
            textFields.append(textField)
            containerStackView.addArrangedSubview(textField)
            arrayOTP.append(String())
        }
        otpStyle(style)
    }

    private func clearAll() {
        arrayOTP.removeAll()
        textFields.removeAll()
        containerStackView.subviews.forEach({ $0.removeFromSuperview() })
    }

    private func setDigit(_ digit: String, atIndex index: Int) {
        if index >= 0, index < textFields.count && index < arrayOTP.count {
            textFields[index].text = digit
            arrayOTP[index] = digit
        }
        validateOTP()
    }

    private func addStyleToUITextFields(selectorColor: UIColor,
                                        font: String,
                                        fontSize: CGFloat,
                                        textColor: UIColor,
                                        backgroundColor: UIColor,
                                        borderStyle: UITextField.BorderStyle,
                                        borderWidth: CGFloat,
                                        borderColor: UIColor,
                                        cornerRadius: CGFloat) {
        textFields.forEach {
            $0.tintColor = selectorColor
            $0.font = UIFont(name: font, size: fontSize)
            $0.textColor = textColor
            $0.backgroundColor = backgroundColor
            $0.isSecureTextEntry = isSecureTextEntry
            $0.borderStyle = borderStyle
            $0.layer.borderWidth = borderWidth
            $0.layer.borderColor = borderColor.cgColor
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = cornerRadius
        }
    }

    private func hidenKeyboard() {
        enableOrDisableUIBtnHidenKeyboard()
    }

    private func enableOrDisableUIBtnHidenKeyboard() {
        for auxTextField in textFields {
            if let text = auxTextField.text, !text.isEmpty {
                hidenKeyboardButton.isHidden = true
            } else {
                hidenKeyboardButton.isHidden = hideKeyboardAutomatically
                break
            }
        }
    }

    private func validateOTP() {
        delegate?.textFieldOTP(self, isValid: arrayOTP.joined().count == textFields.count)
    }

    // MARK: - Private @objc Methods

    @objc
    private func textFieldDidChange(_ textField: UITextFieldCustomOTP) {
        guard let text = textField.text, text.isNotEmpty else { return }
        let stringWithoutSpaces = text.replacingOccurrences(of: " ",
                                                            with: String(),
                                                            options: String.CompareOptions.literal,
                                                            range: nil)
        textFields = textFields.map {
            $0.text?.removeAll(keepingCapacity: true)
            return $0
        }
        var endPosition = 0
        if CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: stringWithoutSpaces)) {
            arrayOTP = arrayOTP.map { _ in
                return String()
            }
            for index in 0..<stringWithoutSpaces.count where index < textFields.count {
                textFields[index].text = String(stringWithoutSpaces[stringWithoutSpaces.index(stringWithoutSpaces.startIndex, offsetBy: index)])
                arrayOTP[index] = String(stringWithoutSpaces[stringWithoutSpaces.index(stringWithoutSpaces.startIndex, offsetBy: index)])
                endPosition = index + 1
            }
        } else {
            for index in 0..<arrayOTP.count where !arrayOTP.isEmpty {
                textFields[index].text = arrayOTP[index]
                if !arrayOTP[index].isEmpty { endPosition = index + 1 }
            }
        }
        if endPosition >= textFields.count, let textField = textFields.last {
            textField.becomeFirstResponder()
        } else {
            textFields[endPosition].becomeFirstResponder()
        }
        validateOTP()
    }

    @objc
    private func showKeyboard(_ button: UIButton) {
        for textField in textFields {
            if let text = textField.text, text.isEmpty {
                textField.becomeFirstResponder()
                break
            }
        }
        button.isHidden = true
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        enableOrDisableUIBtnHidenKeyboard()
    }

}

// MARK: - UITextFieldDelegate.

extension UITextFieldOTP: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if keyboardType == .alphabet {
            let characterSet = CharacterSet(charactersIn: string)
            guard CharacterSet.decimalDigits.isSuperset(of: characterSet) ||
                    CharacterSet.letters.isSuperset(of: characterSet) else {
                return false
            }
        }
        if let textFieldText = textField.text,
           textFieldText.isEmpty,
           string.isEmpty,
           textField.textContentType == .oneTimeCode {
            textFields.forEach {
                $0.text?.removeAll(keepingCapacity: true)
            }
            textFields.first?.becomeFirstResponder()
            return false
        }
        guard let text = textField.text, string != UIPasteboard.general.string else {
            textField.text?.removeAll(keepingCapacity: true)
            return true
        }
        if string.isEmpty && range.length == 1 {
            arrayOTP[textField.tag - 1].removeAll(keepingCapacity: true)
        } else {
            arrayOTP[textField.tag - 1] = string
        }
        validateOTP()
        if text.isEmpty && !string.isEmpty {
            if textField.tag >= textFields.count {
                if hideKeyboardAutomatically, getOTP().count >= textFields.count {
                    textField.resignFirstResponder()
                } else {
                    textField.becomeFirstResponder()
                }
            } else {
                if hideKeyboardAutomatically, getOTP().count >= textFields.count {
                    textField.resignFirstResponder()
                    textFields[textField.tag].resignFirstResponder()
                } else {
                    textField.becomeFirstResponder()
                    textFields[textField.tag].becomeFirstResponder()
                }
            }
            textField.text = string
            return false
        } else if text.count >= 1 && string.isEmpty {
            if let first = textFields.first {
                if first.tag == textField.tag {
                    textField.becomeFirstResponder()
                } else {
                    textFields[textField.tag - 2].becomeFirstResponder()
                }
            }
            textField.text?.removeAll(keepingCapacity: true)
            return false
        } else if text.count >= 1 {
            if textField.tag >= textFields.count {
                textField.becomeFirstResponder()
            } else {
                textFields[textField.tag].becomeFirstResponder()
            }
            textField.text = string
            return false
        }
        return true
    }

}

// MARK: - UITextFieldCustomOTPDelegate
extension UITextFieldOTP: UITextFieldCustomOTPDelegate {

    func deleteBackward(_ textField: UITextFieldCustomOTP) {
        guard let text = textField.text, text.isEmpty, textField.tag > 1 else { return }
        textFields[textField.tag - 2].becomeFirstResponder()
    }

}
