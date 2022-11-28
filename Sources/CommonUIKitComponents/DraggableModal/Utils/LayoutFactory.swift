//
//  LayoutFactory.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

struct LayoutFactory {

    private let spacer: Int = 4
    static let shared: LayoutFactory = LayoutFactory()

    private init() {}

    func getSpacing(with spaces: Int) -> CGFloat {
        CGFloat(spaces * spacer)
    }

}
