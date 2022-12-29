//
//  Button+Haptics.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// Let's not expose this extension
internal extension UIView {

    func hapticFeedbackIfEnabled(config: ButtonConfig) {
        guard isUserInteractionEnabled && config.allowHapticFeedback && !isHidden else {
            return
        }
        let feedback = UIImpactFeedbackGenerator(style: .light)
        feedback.impactOccurred()
    }

}
