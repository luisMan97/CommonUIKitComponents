//
//  Gradient.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

public enum Gradient { }

// MARK: - Direction

public extension Gradient {

    enum Direction: Int, Hashable, CaseIterable {
        case right
        case left
        case bottom
        case top
        case topLeftToBottomRight
        case topRightToBottomLeft
        case bottomLeftToTopRight
        case bottomRightToTopLeft
    }

}

// MARK: - Factory

extension Gradient {

    private static let layerName: String = "RappiLayer"

    /// - parameter parentLayer: the layer that will host the gradient.
    /// - parameter colors: the colors that conform the gradient.
    /// - parameter direction: the direction of the gradient.
    public static func setGradient(in parentLayer: CALayer,
                                   colors: [UIColor],
                                   direction: Direction) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = Gradient.layerName
        gradientLayer.colors = colors.map(\.cgColor)
        // set layer direction
        let (startPoint, endPoint) = gradientPoints(for: direction)
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        // addjust gradient to parent properties
        gradientLayer.frame = parentLayer.bounds
        gradientLayer.cornerRadius = parentLayer.cornerRadius
        // add gradient to layer hierarchy
        if let oldLayer = parentLayer.sublayers?.first(where: { $0.name == Gradient.layerName }) {
            parentLayer.replaceSublayer(oldLayer, with: gradientLayer)
        } else {
            parentLayer.insertSublayer(gradientLayer, at: 0)
        }
    }

    internal static func gradientPoints(
        for direction: Direction,
        with size: CGSize = .init(width: 1.0, height: 1.0)
    ) -> (start: CGPoint, end: CGPoint) {
        var startPoint, endPoint: CGPoint
        switch direction {
        case .right:
            (startPoint, endPoint) = (CGPoint(x: 0.0, y: 0.5), CGPoint(x: 1.0, y: 0.5))
        case .left:
            (startPoint, endPoint) = (CGPoint(x: 1.0, y: 0.5), CGPoint(x: 0.0, y: 0.5))
        case .bottom:
            (startPoint, endPoint) = (CGPoint(x: 0.5, y: 0.0), CGPoint(x: 0.5, y: 1.0))
        case .top:
            (startPoint, endPoint) = (CGPoint(x: 0.5, y: 1.0), CGPoint(x: 0.5, y: 0.0))
        case .topLeftToBottomRight:
            (startPoint, endPoint) = (CGPoint(x: 0.0, y: 0.0), CGPoint(x: 1.0, y: 1.0))
        case .topRightToBottomLeft:
            (startPoint, endPoint) = (CGPoint(x: 1.0, y: 0.0), CGPoint(x: 0.0, y: 1.0))
        case .bottomLeftToTopRight:
            (startPoint, endPoint) = (CGPoint(x: 0.0, y: 1.0), CGPoint(x: 1.0, y: 0.0))
        case .bottomRightToTopLeft:
            (startPoint, endPoint) = (CGPoint(x: 1.0, y: 1.0), CGPoint(x: 0.0, y: 0.0))
        }

        startPoint.x *= size.width
        startPoint.y *= size.height
        endPoint.x *= size.width
        endPoint.y *= size.height

        return (startPoint, endPoint)
    }

}

extension Gradient {

    /// - parameter layer: the layer that will host the gradient.
    /// - parameter direction: the direction of the gradient.
    /// - parameter alpha: the opacity value.
    public static func accentA(
        layer: CALayer,
        direction: Direction = .left,
        alpha: CGFloat = 1
    ) {
        Style.accentA.apply(to: layer, direction: direction, alpha: alpha)
    }

}

// MARK: - Style

public extension Gradient {

    struct Style: Hashable {

        public let colors: [UIColor]

        private init(_ colorName: String) {
            colors = [
                .accentAStart,
                .accentAEnd
            ]
        }
        
        // MARK: Constants

        public static let accentA = Style("accentA")
    }
}

internal extension Gradient.Style {

    func apply(to layer: CALayer,
               direction: Gradient.Direction,
               alpha: CGFloat? = nil) {
        if let alpha = alpha {
            Gradient.setGradient(in: layer,
                                 colors: colors.map({ $0.withAlphaComponent(alpha) }),
                                 direction: direction)
        } else {
            Gradient.setGradient(in: layer,
                                 colors: colors,
                                 direction: direction)
        }
    }
}
