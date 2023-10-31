//
//  Tag.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class Tag {
    var text: String?
    var descriptionTag: String?
    var iconUrl: String?

    init(text: String? = nil,
         descriptionTag: String? = nil,
         iconUrl: String? = nil) {
        self.text = text
        self.descriptionTag = descriptionTag
        self.iconUrl = iconUrl
    }
}
