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
    
    private var containerStackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
    }

    private var alertImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private var alertImageSubView: UIView?

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
            containerStackView.updateSubViewConstraint(identifier: "alertImageViewTop", constant: alertImageViewPaddingTop)
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
            containerStackView.updateSubViewConstraint(identifier: "titleLabelTop", constant: titleLabelPaddingTop)
        }
    }
    
    public var titleLabelPaddingBottom: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "titleLabelBottom", constant: -titleLabelPaddingBottom)
        }
    }
    
    public var titleLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "titleLabelLeft", constant: titleLabelPaddingLeft)
        }
    }
    
    public var titleLabelPaddingRight: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "titleLabelRight", constant: -titleLabelPaddingRight)
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
            containerStackView.updateSubViewConstraint(identifier: "messageLabelTop", constant: messageLabelPaddingTop)
        }
    }
    
    public var messageLabelPaddingBottom: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "messageLabelBottom", constant: -messageLabelPaddingBottom)
        }
    }
    
    public var messageLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "messageLabelLeft", constant: messageLabelPaddingLeft)
        }
    }
    
    public var messageLabelPaddingRight: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "messageLabelRight", constant: -messageLabelPaddingRight)
        }
    }
    
    // MARK: - Private Properties
    
    private var imageIsHidden = false
    private var titleIsHidden = false
    private var messageIsHidden = false

    // MARK: - Override Methods

    public override func configureView() {
        super.configureView()
        addViews()
        DispatchQueue.main.async { [self] in
            hideOrShowImageIfNecessary()
            hideOrShowTitleIfNecessary()
            hideOrShowMessageIfNecessary()
        }
    }
    
    public func addSubViewIntoImageView(_ view: UIView) {
        alertImageSubView = view
        alertImageSubView?.fixInView(alertImageView)
    }

    // MARK: - Private Methods

    private func addViews() {
        let alertImageViewInsets = UIEdgeInsets(top: Layout.errorImagePaddingTop,
                                                left: 0,
                                                bottom: 0,
                                                right: 0)
        let titleLabelInsets = UIEdgeInsets(top: Layout.titleLabelPaddingTop,
                                            left: Layout.titleLabelPaddingLeft,
                                            bottom: 0,
                                            right: Layout.titleLabelPaddingRight)
        let messageLabelInsets = UIEdgeInsets(top: Layout.messageLabelPaddingTop,
                                              left: Layout.messageLabelPaddingLeft,
                                              bottom: Layout.messageLabelPaddingBottom,
                                              right: Layout.messageLabelPaddingRight)
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(alertImageView,
                                               withMargin: alertImageViewInsets,
                                               identifier: "alertImageView")
        containerStackView.addArrangedSubview(titleLabel,
                                               withMargin: titleLabelInsets,
                                               identifier: "titleLabel")
        containerStackView.addArrangedSubview(messageLabel,
                                               withMargin: messageLabelInsets,
                                               identifier: "messageLabel")

        addConstraints()
    }

    private func addConstraints() {
        containerStackView.fixInView(self)
        
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
        hideOrShowImageIfNecessary()
    }
    
    private func hideOrShowImageIfNecessary() {
        guard alertImageView.image == nil, alertImageSubView == nil else {
            if imageIsHidden { reAddTheImage() }
            return
        }
        hideImage()
    }
    
    private func reAddTheImage() {
        imageIsHidden = false
        let alertImageViewInsets = UIEdgeInsets(top: Layout.errorImagePaddingTop, left: 0, bottom: 0, right: 0)
        containerStackView.insertArrangedSubview(alertImageView,
                                                 at: 0,
                                                 withMargin: alertImageViewInsets,
                                                 identifier: "alertImageView")
    }
    
    private func hideImage() {
        guard let alertImage = alertImageView.superview else {
            return
        }
        imageIsHidden = true
        containerStackView.removeArrangedSubview(alertImage)
    }
    
    private func setTitleText(_ text: String?) {
        titleLabel.text = text
        hideOrShowTitleIfNecessary()
    }
    
    private func setTitleAttributedText(_ attributedString: NSAttributedString?) {
        titleLabel.attributedText = attributedString
        hideOrShowTitleIfNecessary()
    }
    
    private func hideOrShowTitleIfNecessary() {
        if let titleText = titleLabel.text {
            guard titleText.isEmpty else {
                if titleIsHidden { reAddTheTitle() }
                return
            }
            hideTitle()
        } else if let titleAttributedText = titleLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                if titleIsHidden { reAddTheTitle() }
                return
            }
            hideTitle()
        } else {
            hideTitle()
        }
    }
    
    private func reAddTheTitle() {
        titleIsHidden = false
        let titleLabelInsets = UIEdgeInsets(top: Layout.titleLabelPaddingTop,
                                            left: Layout.titleLabelPaddingLeft,
                                            bottom: 0,
                                            right: Layout.titleLabelPaddingRight)
        
        if imageIsHidden { // Insert first
            containerStackView.insertArrangedSubview(titleLabel,
                                                     at: 0,
                                                     withMargin: titleLabelInsets,
                                                     identifier: "titleLabel")
        } else if messageIsHidden { // Insert last (normal)
            containerStackView.addArrangedSubview(titleLabel,
                                                  withMargin: titleLabelInsets,
                                                  identifier: "titleLabel")
        } else { // Insert below alertImageView
            containerStackView.insertArrangedSubview(titleLabel,
                                                     belowArrangedSubview: alertImageView,
                                                     withMargin: titleLabelInsets,
                                                     identifier: "titleLabel")
        }
    }
    
    private func hideTitle() {
        guard let containerTitleLabel = titleLabel.superview else {
            return
        }
        titleIsHidden = true
        containerStackView.removeArrangedSubview(containerTitleLabel)
    }
    
    private func setMessageText(_ text: String?) {
        messageLabel.text = text
        hideOrShowMessageIfNecessary()
    }
    
    private func setMessageAttributedText(_ attributedString: NSAttributedString?) {
        messageLabel.attributedText = attributedString
        hideOrShowMessageIfNecessary()
    }
    
    private func hideOrShowMessageIfNecessary() {
        if let titleText = messageLabel.text {
            guard titleText.isEmpty else {
                if messageIsHidden { reAddTheMessage() }
                return
            }
            hideMessage()
        } else if let titleAttributedText = messageLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                if messageIsHidden { reAddTheMessage() }
                return
            }
            hideMessage()
        } else {
            hideMessage()
        }
    }
    
    private func reAddTheMessage() {
        messageIsHidden = false
        let messageLabelInsets = UIEdgeInsets(top: Layout.messageLabelPaddingTop,
                                              left: Layout.messageLabelPaddingLeft,
                                              bottom: Layout.messageLabelPaddingBottom,
                                              right: Layout.messageLabelPaddingRight)
        containerStackView.addArrangedSubview(messageLabel,
                                              withMargin: messageLabelInsets,
                                              identifier: "messageLabel")
    }
    
    private func hideMessage() {
        guard let containerMessageLabel = messageLabel.superview else {
            return
        }
        messageIsHidden = true
        containerStackView.removeArrangedSubview(containerMessageLabel)
        addTitleBottomIfNecessary()
    }
    
    private func addTitleBottomIfNecessary() {
        guard titleLabelPaddingBottom == 0 else {
            return
        }
        titleLabelPaddingBottom = Layout.titleLabelPaddingBottom
    }
    
}

