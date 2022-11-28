//
//  Characters.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 19/11/22.
//

import Foundation

@objc
public enum Characters: Int {
    case alphabetLowerCase
    case alphabetUpperCase
    case numbers
    case whiteSpace
    case alphabet
    case alphanumeric
    case alphanumericAndWhiteSpaces
    // Accents
    case accentedLowerCaseVocals
    case accentedUpperCaseVocals
    case alphabetWithAccentsLowerCase
    case alphabetWithAccentsUpperCase
    case alphabetWithAccents
    case alphanumericWithAccents
    case alphanumericAndWhiteSpacesWithAccents
    
    var stringValue: String {
        switch self {
        case .alphabetLowerCase: return Characters.alphabetLowerCaseConstant
        case .alphabetUpperCase: return Characters.alphabetUpperCaseConstant
        case .numbers: return Characters.numbersConstant
        case .whiteSpace: return Characters.whiteSpaceConstant
        case .alphabet: return Characters.alphabetConstant
        case .alphanumeric: return Characters.alphanumericConstant
        case .alphanumericAndWhiteSpaces: return Characters.alphanumericAndWhiteSpacesConstant
            // Accents
        case .accentedLowerCaseVocals: return Characters.accentedLowerCaseVocalsConstant
        case .accentedUpperCaseVocals: return Characters.accentedUpperCaseVocalsConstant
        case .alphabetWithAccentsLowerCase: return Characters.alphabetWithAccentsLowerCaseConstant
        case .alphabetWithAccentsUpperCase: return Characters.alphabetWithAccentsUpperCaseConstant
        case .alphabetWithAccents: return Characters.alphabetWithAccentsConstant
        case .alphanumericWithAccents: return Characters.alphanumericWithAccentsConstant
        case .alphanumericAndWhiteSpacesWithAccents: return Characters.alphanumericAndWhiteSpacesWithAccentsConstant
        }
    }
    
    static let alphabetLowerCaseConstant = "abcdefghijklmnopqrstuvwxyz"
    static let alphabetUpperCaseConstant = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    static let numbersConstant = "0123456789"
    static let whiteSpaceConstant = "\(CharacterSet.whitespaces)"
    static let alphabetConstant = alphabetLowerCaseConstant + alphabetUpperCaseConstant
    static let alphanumericConstant = alphabetConstant + numbersConstant
    static let alphanumericAndWhiteSpacesConstant = alphanumericConstant + whiteSpaceConstant
    // Accents
    static let accentedLowerCaseVocalsConstant = "áéíóú"
    static let accentedUpperCaseVocalsConstant = "ÁÉÍÓÚ"
    static let alphabetWithAccentsLowerCaseConstant = alphabetLowerCaseConstant + accentedLowerCaseVocalsConstant
    static let alphabetWithAccentsUpperCaseConstant = alphabetUpperCaseConstant + accentedUpperCaseVocalsConstant
    static let alphabetWithAccentsConstant = alphabetWithAccentsLowerCaseConstant + alphabetWithAccentsUpperCaseConstant
    static let alphanumericWithAccentsConstant = alphabetWithAccentsConstant + numbersConstant
    static let alphanumericAndWhiteSpacesWithAccentsConstant = alphanumericWithAccentsConstant + whiteSpaceConstant
}
