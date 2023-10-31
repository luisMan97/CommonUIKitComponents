//
//  BundleExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public extension Bundle {

    func has(xib: String) -> Bool {
        return path(forResource: xib, ofType: "nib") != nil
    }

}

