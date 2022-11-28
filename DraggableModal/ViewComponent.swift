//
//  ViewComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 27/11/22.
//

import UIKit

// ViewComponent is used to expose the UIView when using a component of type UIView
// should generally be inherited by the component's wrapper or others protocols
public protocol ViewComponent {
    var base: UIView { get }
}
