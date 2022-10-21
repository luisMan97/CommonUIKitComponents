//
//  UIControlExtensions.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 1/09/22.
//

import UIKit

private class ClosureSleeve {
    
    let closure: CompletionHandler
    
    init(_ closure: @escaping CompletionHandler) {
        self.closure = closure
    }
    
    @objc
    func invoke() {
        closure()
    }
    
}

public extension UIControl {
    
    func deleteActions(){
        removeTarget(nil, action: nil, for: .allEvents)
    }
    
    func addTargetAction(for controlEvents: UIControl.Event, _ closure: @escaping CompletionHandler, deleteFirstActions: Bool = true) {
        if deleteFirstActions { deleteActions() }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
