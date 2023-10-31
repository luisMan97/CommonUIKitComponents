//
//  ModalHeaderComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// ModalDataSource  is used to expose the correct height that the header should have
// Minimum height is used for possible header collapse
// Header is on top is used to indicate when the decorator should expand
public protocol ModalHeaderComponent: ViewComponent {
    var height: CGFloat { get }
    var minHeight: CGFloat { get }
    var isFloating: Bool { get }
    var isHeaderOnTop: Bool { get set }
    var collectionOffset: CGPoint? { get set }
}

// MARK: - ModalHeaderComponent Default Implementation
public extension ModalHeaderComponent {

    var height: CGFloat { 76.0 }

    var minHeight: CGFloat { height }

    var isFloating: Bool { false }

    var collectionOffset: CGPoint? {
        get { return nil }
        set { }
    }

}
