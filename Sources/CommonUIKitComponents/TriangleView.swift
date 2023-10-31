//
//  TriangleView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

class TriangleView: UIView {

    // MARK: - Private Properties

    private var colorFilled: UIColor = .black

    // MARK: - Initializers

    init(frame: CGRect, color: UIColor) {
        self.colorFilled = color
        super.init(frame: frame)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Override Methods

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()
        context.move(to: .init(x: rect.minX, y: rect.maxY))
        context.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        context.addLine(to: .init(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        context.setFillColor(red: colorFilled.rgba.red,
                             green: colorFilled.rgba.green,
                             blue: colorFilled.rgba.blue,
                             alpha: colorFilled.rgba.alpha)
        context.fillPath()
    }

}
