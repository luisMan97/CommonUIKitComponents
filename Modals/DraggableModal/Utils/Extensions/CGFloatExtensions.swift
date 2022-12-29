//
//  CGFloatExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import Foundation

public extension CGFloat {

    static func spacing(_ spaces: Int) -> CGFloat {
        LayoutFactory.shared.getSpacing(with: spaces)
    }

}
