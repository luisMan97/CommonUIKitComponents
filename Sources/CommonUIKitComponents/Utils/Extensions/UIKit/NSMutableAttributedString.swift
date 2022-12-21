//
//  NSMutableAttributedString.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 20/12/22.
//

import UIKit

extension NSMutableAttributedString {
    
    func setFont(font: UIFont, forText stringValue: String) {
        let range = mutableString.range(of: stringValue, options: .caseInsensitive)
        addAttribute(.font, value: font, range: range)
    }
    
    @discardableResult
    func font(_ font: UIFont, text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font]
        let boldString = NSMutableAttributedString(string: text, attributes: attrs)
        append(boldString)
        return self
    }
    
}
