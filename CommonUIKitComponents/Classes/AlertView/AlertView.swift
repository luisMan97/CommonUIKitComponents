//
//  AlertView.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

import UIKit

public class AlertView: BaseUIView {

    typealias Layout = AlertLayout

    // MARK: - Private UI Properties
    
    private var containserStackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
    }

    private var alertImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private var titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private var messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    // MARK: - Public Properties
    
    public var alertType: AlertType = .custom {
        didSet {
           setAlertType()
        }
    }

    /// The alert image.
    public var alertImage: UIImage? {
        get { alertImageView.image }
        set { setAlertImage(newValue) }
    }
    
    public var alertImageViewPaddingTop: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "alertImageViewTop", constant: alertImageViewPaddingTop)
        }
    }
    
    public var alertImageViewHeight: CGFloat = 0 {
        didSet {
            alertImageView.updateConstraint(identifier: "alertImageViewHeight", constant: alertImageViewHeight)
        }
    }

    public var alertImageViewWidth: CGFloat = 0 {
        didSet {
            alertImageView.updateConstraint(identifier: "alertImageViewWidth", constant: alertImageViewWidth)
        }
    }
    
    /// The title text in String.
    public var titleText: String? {
        get { titleLabel.text ?? "" }
        set { setTitleText(newValue) }
    }

    /// The title attributed text in NSAttributedString.
    public var titleAttributedText: NSAttributedString? {
        get { titleLabel.attributedText }
        set { setTitleAttributedText(newValue) }
    }

    /// The title text font.
    public var titleTextFont: UIFont? {
        get { titleLabel.font }
        set { titleLabel.font = newValue }
    }

    /// The title text color.
    public var titleTextColor: UIColor {
        get { titleLabel.textColor }
        set { titleLabel.textColor = newValue }
    }
    
    public var titleLabelPaddingTop: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "titleLabelTop", constant: titleLabelPaddingTop)
        }
    }
    
    public var titleLabelPaddingBottom: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "titleLabelBottom", constant: -titleLabelPaddingBottom)
        }
    }
    
    public var titleLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "titleLabelLeft", constant: titleLabelPaddingLeft)
        }
    }
    
    public var titleLabelPaddingRight: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "titleLabelRight", constant: -titleLabelPaddingRight)
        }
    }
    
    /// The message text in string.
    public var messageText: String? {
        get { messageLabel.text ?? "" }
        set { setMessageText(newValue) }
    }

    /// The message attributed text in NSAttributedString.
    public var messageAttributedText: NSAttributedString? {
        get { messageLabel.attributedText }
        set { setMessageAttributedText(newValue) }
    }

    /// The message text font.
    public var messageTextFont: UIFont? {
        get { messageLabel.font }
        set { messageLabel.font = newValue }
    }
    /// The message text color.
    public var messageTextColor: UIColor {
        get { messageLabel.textColor }
        set { messageLabel.textColor = newValue }
    }
    
    public var messageLabelPaddingTop: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "messageLabelTop", constant: messageLabelPaddingTop)
        }
    }
    
    public var messageLabelPaddingBottom: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "messageLabelBottom", constant: -messageLabelPaddingBottom)
        }
    }
    
    public var messageLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "messageLabelLeft", constant: messageLabelPaddingLeft)
        }
    }
    
    public var messageLabelPaddingRight: CGFloat = 0 {
        didSet {
            containserStackView.updateSubViewConstraint(identifier: "messageLabelRight", constant: -messageLabelPaddingRight)
        }
    }

    // MARK: - Override Methods

    public override func configureView() {
        super.configureView()
        addViews()
        DispatchQueue.main.async { [self] in
            hideImageIfNecessary()
            hideTitleIfNecessary()
            hideMessageIfNecessary()
        }
    }
    
    public func addSubViewIntoImageView(_ view: UIView) {
        view.fixInView(alertImageView)
    }

    // MARK: - Private Methods

    private func addViews() {
        let alertImageViewInsets = UIEdgeInsets(top: Layout.errorImagePaddingTop, left: 0, bottom: 0, right: 0)
        let titleLabelInsets = UIEdgeInsets(top: Layout.titleLabelPaddingTop, left: Layout.titleLabelPaddingLeft, bottom: 0, right: Layout.titleLabelPaddingRight)
        let messageLabelInsets = UIEdgeInsets(top: Layout.messageLabelPaddingTop, left: Layout.messageLabelPaddingLeft, bottom: Layout.messageLabelPaddingBottom, right: Layout.messageLabelPaddingRight)
        
        addSubview(containserStackView)
        containserStackView.addArrangedSubview(alertImageView,
                                               withMargin: alertImageViewInsets,
                                               identifier: "alertImageView")
        containserStackView.addArrangedSubview(titleLabel,
                                               withMargin: titleLabelInsets,
                                               identifier: "titleLabel")
        containserStackView.addArrangedSubview(messageLabel,
                                               withMargin: messageLabelInsets,
                                               identifier: "messageLabel")

        addConstraints()
    }

    private func addConstraints() {
        containserStackView.fixInView(self)
        
        // errorImage
        alertImageView.anchor(width: Layout.errorImageWidth,
                              height: Layout.errorImageHeight,
                              centerX: self,
                              identifier: "alertImageView")
    }
    
    private func setAlertType() {
        guard alertType != .custom else {
            return
        }
        if alertImage == nil {
            if case .success = alertType {
                if #available(iOS 13.0, *) {
                    alertImage = .init(systemName: "checkmark.circle.fill")
                    alertImageView.tintColor = .systemGreen
                }
            }
            if case .failure = alertType {
                if #available(iOS 13.0, *) {
                    alertImage = .init(systemName: "x.circle.fill")
                    alertImageView.tintColor = .systemRed
                }
            }
        }
    }
    
    private func setAlertImage(_ image: UIImage?) {
        alertImageView.image = image
        hideImageIfNecessary()
    }
    
    private func hideImageIfNecessary() {
        guard alertImageView.image == nil else {
            return
        }
        hideImage()
    }
    
    private func hideImage() {
        guard let alertImage = alertImageView.superview else {
            return
        }
        containserStackView.removeArrangedSubview(alertImage)
    }
    
    private func setTitleText(_ text: String?) {
        titleLabel.text = text
        hideTitleIfNecessary()
    }
    
    private func setTitleAttributedText(_ attributedString: NSAttributedString?) {
        titleLabel.attributedText = attributedString
        hideTitleIfNecessary()
    }
    
    private func hideTitleIfNecessary() {
        if let titleText = titleLabel.text {
            guard titleText.isEmpty else {
                return
            }
            hideTitle()
        } else if let titleAttributedText = titleLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                return
            }
            hideTitle()
        } else {
            hideTitle()
        }
    }
    
    private func hideTitle() {
        guard let containerTitleLabel = titleLabel.superview else {
            return
        }
        containserStackView.removeArrangedSubview(containerTitleLabel)
    }
    
    private func setMessageText(_ text: String?) {
        messageLabel.text = text
        hideMessageIfNecessary()
    }
    
    private func setMessageAttributedText(_ attributedString: NSAttributedString?) {
        messageLabel.attributedText = attributedString
        hideMessageIfNecessary()
    }
    
    private func hideMessageIfNecessary() {
        if let titleText = messageLabel.text {
            guard titleText.isEmpty else {
                return
            }
            hideMessage()
        } else if let titleAttributedText = messageLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                return
            }
            hideMessage()
        } else {
            hideMessage()
        }
    }
    
    private func hideMessage() {
        guard let containerMessageLabel = messageLabel.superview else {
            return
        }
        containserStackView.removeArrangedSubview(containerMessageLabel)
        addTitleBottomIfNecessary()
    }
    
    private func addTitleBottomIfNecessary() {
        guard titleLabelPaddingBottom == 0 else {
            return
        }
        titleLabelPaddingBottom = Layout.titleLabelPaddingBottom
    }
    
}

