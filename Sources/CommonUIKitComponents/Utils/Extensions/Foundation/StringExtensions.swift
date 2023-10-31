//
//  StringExtensions.swift
//  UIKitCommons
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import Foundation

extension String {

    var isNotEmpty: Bool { !self.isEmpty }
    
    ///  Function *containsOnlyCharactersIn* validate if the extended string is only composed with matchCharacters String parameter.
    /// - Parameter matchCharacters: String parameter to compare with the extended string.
    /// - Returns: Return true if a string is made up of only "matchCharacters".
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = CharacterSet(charactersIn: matchCharacters).inverted
        return rangeOfCharacter(from: disallowedCharacterSet) == nil
    }

}
