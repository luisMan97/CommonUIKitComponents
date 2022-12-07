//
//  UITextFieldOTPExampleController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

class UITextFieldOTPExampleController: UIViewController {
    
    // MARK: - Private UI Properties
    
    private lazy var textField = UITextFieldOTP().then {
        $0.delegate = self
        $0.numberOfTextFields = 4
        $0.spacing = 20
        $0.setupWhenBuildingUIProgrammatically()
    }
    
    // MARK: - UIViewController Lyfecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        view.addSubview(textField)
        addConstraints()
    }
    
    private func addConstraints() {
        textField.anchor(left: view.leftAnchor,
                         paddingLeft: 20,
                         right: view.rightAnchor,
                         paddingRight: 20,
                         height: 50,
                         centerY: view)
    }
    
}

extension UITextFieldOTPExampleController: UITextFieldOTPDelegate {
    
    func textFieldOTP(_ textFieldOTP: UITextFieldOTP, isValid: Bool) {
        
    }

}
