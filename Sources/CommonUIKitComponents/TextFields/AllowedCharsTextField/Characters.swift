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
    case alphabetAndWhiteSpaces
    case alphanumeric
    case alphanumericAndWhiteSpaces
    // Accents
    case accentedLowerCaseVocals
    case accentedUpperCaseVocals
    case alphabetWithAccentsLowerCase
    case alphabetWithAccentsUpperCase
    case alphabetWithAccents
    case alphabetAndWhiteSpacesWithAccents
    case alphanumericWithAccents
    case alphanumericAndWhiteSpacesWithAccents

    public var stringValue: String {
        switch self {
        case .alphabetLowerCase: return Characters.alphabetLowerCaseConstant
        case .alphabetUpperCase: return Characters.alphabetUpperCaseConstant
        case .numbers: return Characters.numbersConstant
        case .whiteSpace: return Characters.whiteSpaceConstant
        case .alphabet: return Characters.alphabetConstant
        case .alphabetAndWhiteSpaces: return Characters.alphabetAndWhiteSpacesConstant
        case .alphanumeric: return Characters.alphanumericConstant
        case .alphanumericAndWhiteSpaces: return Characters.alphanumericAndWhiteSpacesConstant
            // Accents
        case .accentedLowerCaseVocals: return Characters.accentedLowerCaseVocalsConstant
        case .accentedUpperCaseVocals: return Characters.accentedUpperCaseVocalsConstant
        case .alphabetWithAccentsLowerCase: return Characters.alphabetWithAccentsLowerCaseConstant
        case .alphabetWithAccentsUpperCase: return Characters.alphabetWithAccentsUpperCaseConstant
        case .alphabetWithAccents: return Characters.alphabetWithAccentsConstant
        case .alphabetAndWhiteSpacesWithAccents: return Characters.alphabetAndWhiteSpacesWithAccentsConstant
        case .alphanumericWithAccents: return Characters.alphanumericWithAccentsConstant
        case .alphanumericAndWhiteSpacesWithAccents: return Characters.alphanumericAndWhiteSpacesWithAccentsConstant
        }
    }

    public static let alphabetLowerCaseConstant = "abcdefghijklmnopqrstuvwxyz"
    public static let alphabetUpperCaseConstant = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    public static let numbersConstant = "0123456789"
    public static let whiteSpaceConstant = "\(CharacterSet.whitespaces)"
    public static let alphabetConstant = alphabetLowerCaseConstant + alphabetUpperCaseConstant
    public static let alphabetAndWhiteSpacesConstant = alphabetConstant + whiteSpaceConstant
    public static let alphanumericConstant = alphabetConstant + numbersConstant
    public static let alphanumericAndWhiteSpacesConstant = alphanumericConstant + whiteSpaceConstant
    // Accents
    public static let accentedLowerCaseVocalsConstant = "áéíóú"
    public static let accentedUpperCaseVocalsConstant = "ÁÉÍÓÚ"
    public static let alphabetWithAccentsLowerCaseConstant = alphabetLowerCaseConstant + accentedLowerCaseVocalsConstant
    public static let alphabetWithAccentsUpperCaseConstant = alphabetUpperCaseConstant + accentedUpperCaseVocalsConstant
    public static let alphabetWithAccentsConstant = alphabetWithAccentsLowerCaseConstant + alphabetWithAccentsUpperCaseConstant
    public static let alphabetAndWhiteSpacesWithAccentsConstant = alphabetWithAccentsConstant + whiteSpaceConstant
    public static let alphanumericWithAccentsConstant = alphabetWithAccentsConstant + numbersConstant
    public static let alphanumericAndWhiteSpacesWithAccentsConstant = alphanumericWithAccentsConstant + whiteSpaceConstant
}
