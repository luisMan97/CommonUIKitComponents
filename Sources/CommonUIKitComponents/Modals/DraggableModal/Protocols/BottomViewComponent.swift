//
//  BottomViewComponent.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// Height is used for the constraints
// OnClose is used to give instructions to close the modal
public protocol BottomViewComponent: ViewComponent {
    var height: CGFloat { get }
    var onClose: Observable<Void> { get }
    func viewDidLoad()
    func animateAppear(_ appeared: Bool)
}

// MARK: - BottomComponent Default Implementation
public extension BottomViewComponent {
    var height: CGFloat { 122.0 }
    var onClose: Observable<Void> { Observable<Void>() }
    
    func viewDidLoad() {}
}

