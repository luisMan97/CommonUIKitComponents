//
//  UIView+Constraints.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//
 
public extension UIView {
    
    func fixInView(_ container: UIView) {
        container.addSubview(self)
        activateNSLayoutAnchor(container)
    }

    @objc
    func activateNSLayoutAnchor(_ container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    func constraintWith(identifier: String) -> NSLayoutConstraint? {
        constraints.first { $0.identifier == identifier }
    }
    
    func updateConstraint(identifier: String, constant: CGFloat) {
        if let constraint = constraintWith(identifier: identifier) {
            constraint.constant = constant
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                bottom: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                left: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                right: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                width: CGFloat = 0,
                height: CGFloat = 0,
                centerX: UIView? = nil,
                paddingCenterX: CGFloat = 0,
                centerY: UIView? = nil,
                paddingCenterY: CGFloat = 0,
                identifier: String
    ) {
        anchor(top: top,
               paddingTop: paddingTop,
               topIdentifier: "\(identifier)Top",
               bottom: bottom,
               paddingBottom: paddingBottom,
               bottomIdentifier: "\(identifier)Bottom",
               left: left,
               paddingLeft: paddingLeft,
               leftIdentifier: "\(identifier)Left",
               right: right,
               paddingRight: paddingRight,
               rightIdentifier: "\(identifier)Right",
               width: width,
               widthdIentifier: "\(identifier)Width",
               height: height,
               heightIentifier: "\(identifier)Height",
               centerX: centerX,
               paddingCenterX: paddingCenterX,
               centerXIdentifier: "\(identifier)CenterX",
               centerY: centerY,
               paddingCenterY: paddingCenterY,
               centerYIdentifier: "\(identifier)CenterY")
    }

    /// Setup constraints view
    ///
    /// - Parameters:
    ///   - top: `nil` by default.
    ///   - paddingTop: `0` by default.
    ///   - bottom: `nil` by default.
    ///   - paddingBottom: `0` by default.
    ///   - left: `nil` by default.
    ///   - paddingLeft: `0` by default.
    ///   - right: `nil` by default.
    ///   - paddingRight: `0` by default.
    ///   - width: `0` by default.
    ///   - height: `0` by default.
    ///   - centerX: `nil` by default.
    ///   - paddingCenterX: `0` by default.
    ///   - centerY: `nil` by default.
    ///   - paddingCenterY: `0` by default.
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                topGreaterThanOrEqualTo: NSLayoutYAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                topIdentifier: String? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                bottomLessThanOrEqualTo: NSLayoutYAxisAnchor? = nil,
                paddingBottom: CGFloat = 0,
                bottomIdentifier: String? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                leftIdentifier: String? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingRight: CGFloat = 0,
                rightIdentifier: String? = nil,
                width: CGFloat = 0,
                widthdIentifier: String? = nil,
                height: CGFloat = 0,
                heightIentifier: String? = nil,
                centerX: UIView? = nil,
                paddingCenterX: CGFloat = 0,
                centerXIdentifier: String? = nil,
                centerY: UIView? = nil,
                paddingCenterY: CGFloat = 0,
                centerYIdentifier: String? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraint(anchor: topAnchor, equalTo: top, identifer: topIdentifier, padding: paddingTop)
        setupConstraint(anchor: topAnchor, greaterThanOrEqualTo: topGreaterThanOrEqualTo, identifer: topIdentifier, padding: paddingTop)
        setupConstraint(anchor: bottomAnchor, equalTo: bottom, identifer: bottomIdentifier, padding: -paddingBottom)
        setupConstraint(anchor: bottomAnchor, lessThanOrEqualTo: bottomLessThanOrEqualTo, identifer: bottomIdentifier, padding: -paddingBottom)
        setupConstraint(anchor: rightAnchor, equalTo: right, identifer: rightIdentifier, padding: -paddingRight)
        setupConstraint(anchor: leftAnchor, equalTo: left, identifer: leftIdentifier, padding: paddingLeft)
        setupConstraint(anchor: widthAnchor, equalTo: width, identifer: widthdIentifier)
        setupConstraint(anchor: heightAnchor, equalTo: height, identifer: heightIentifier)
        setupConstraint(anchor: centerXAnchor, equalTo: centerX?.centerXAnchor, identifer: centerXIdentifier, padding: paddingCenterX)
        setupConstraint(anchor: centerYAnchor, equalTo: centerY?.centerYAnchor, identifer: centerYIdentifier, padding: paddingCenterY)
    }
    
    func setupConstraint(anchor: NSLayoutYAxisAnchor, greaterThanOrEqualTo verticalAnchor: NSLayoutYAxisAnchor?, identifer: String?, padding: CGFloat) {
        guard let verticalAnchor = verticalAnchor else {
            return
        }
        let anchor = anchor.constraint(greaterThanOrEqualTo: verticalAnchor, constant: padding)
        if let identifer = identifer {
            anchor.identifier = identifer
        }
        anchor.isActive = true
    }
    
    func setupConstraint(anchor: NSLayoutYAxisAnchor, lessThanOrEqualTo verticalAnchor: NSLayoutYAxisAnchor?, identifer: String?, padding: CGFloat) {
        guard let verticalAnchor = verticalAnchor else {
            return
        }
        let anchor = anchor.constraint(lessThanOrEqualTo: verticalAnchor, constant: padding)
        if let identifer = identifer {
            anchor.identifier = identifer
        }
        anchor.isActive = true
    }
    
    func setupConstraint(anchor: NSLayoutYAxisAnchor, equalTo verticalAnchor: NSLayoutYAxisAnchor?, identifer: String?, padding: CGFloat) {
        guard let verticalAnchor = verticalAnchor else {
            return
        }
        let anchor = anchor.constraint(equalTo: verticalAnchor, constant: padding)
        if let identifer = identifer {
            anchor.identifier = identifer
        }
        anchor.isActive = true
    }
    
     func setupConstraint(anchor: NSLayoutXAxisAnchor, equalTo horizontalAnchor: NSLayoutXAxisAnchor?, identifer: String?, padding: CGFloat) {
        guard let horizontalAnchor = horizontalAnchor else {
            return
        }
        let anchor = anchor.constraint(equalTo: horizontalAnchor, constant: padding)
        if let identifer = identifer {
            anchor.identifier = identifer
        }
        anchor.isActive = true
    }
    
    func setupConstraint(anchor: NSLayoutDimension, equalTo constant: CGFloat, identifer: String?) {
        guard constant != 0 else {
            return
        }
        let anchor = anchor.constraint(equalToConstant: constant)
        if let identifer = identifer {
            anchor.identifier = identifer
        }
        anchor.isActive = true
    }
    
}
