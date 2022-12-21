//
//  LabelComponentView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 20/12/22.
//

import UIKit

public enum AttachmentPlacement {
    case trailing
    case leading
}

class LabelComponentView: BaseComponentView {

    // MARK: - Private UI Properties

    private var contentStackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
        $0.layer.cornerRadius = 11.5
    }
    
    private var imagePosition: Int { imagePlacement == .leading ? 0 : 1 }
    
    // MARK: - Public Properties
    
    public var imagePlacement: AttachmentPlacement = .leading
    
    public var pillBackgroundColor: UIColor? {
        get { contentStackView.backgroundColor }
        set { contentStackView.backgroundColor = newValue }
    }
    
    public var image: UIImage? {
        get { iconImageView.image }
        set { setImage(newValue) }
    }
    
    public var text: String? {
        get { textLabel.text }
        set { setText(newValue) }
    }
    
    public var textColor: UIColor? {
        get { textLabel.textColor }
        set { textLabel.textColor = newValue }
    }
    
    public var textFont: UIFont {
        get { textLabel.font }
        set { textLabel.font = newValue }
    }
    
    public var attributedString: NSAttributedString? {
        get { textLabel.attributedText }
        set { setAttributedString(newValue) }
    }
    
    // MARK: - Private Properties
    
    private let textLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    private let textLabelContainer = ComponentContainerView()
    private let iconImageView = UIImageView().then {
        $0.isHidden = true
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Override Methods
    
    override func basicSetup() {
        super.basicSetup()
        addSubViews()
    }
    
    func updateSpacingInside(_ spacing: CGFloat) {
        contentStackView.spacing = spacing
    }
    
    func updateTextMarginConstraints(insets: UIEdgeInsets) {
        textLabelContainer.componentInset = insets
    }
    
    func updateImage(_ image: UIImage?) {
        guard let image = image else {
            contentStackView.removeArrangedSubviewAndFromSuperview(iconImageView)
            return
        }
        let iconImageViewMargins = UIEdgeInsets(top: 5, left: 9, bottom: 5, right: 0)
        let iconImageViewHeight = min(image.size.height, 13)
        let iconImageViewWidth = min(image.size.width, 15)
        contentStackView.insertArrangedSubview(iconImageView,
                                               at: imagePosition,
                                               withMargin: iconImageViewMargins)
        iconImageView.then {
            $0.anchor(width: iconImageViewWidth, height: iconImageViewHeight)
            $0.isHidden = false
            $0.image = image
        }
    }
    
    // MARK: - Private Methods

    private func addSubViews() {
        addSubview(contentStackView)
        textLabelContainer.add(component: textLabel)
        contentStackView.addArrangedSubview(textLabelContainer)
        addConstraints()
    }

    private func addConstraints() {
        let topConstraint = contentStackView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let leadingConstraint = contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailingConstraint = contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([leadingConstraint, topConstraint, trailingConstraint, bottomConstraint])
        self.topConstraint = topConstraint
        self.bottomConstraint = bottomConstraint
        self.leadingConstraint = leadingConstraint
        self.trailingConstraint = trailingConstraint
    }
    
    private func setImage(_ image: UIImage?) {
        updateImage(image)
    }

    private func setText(_ text: String?) {
        textLabel.text = text
    }

    private func setAttributedString(_ attributedString: NSAttributedString?) {
        textLabel.attributedText = attributedString
    }
    
}
