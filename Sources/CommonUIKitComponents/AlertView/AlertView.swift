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

    private let containerStackView = UIStackView().then {
        $0.spacing = .zero
        $0.axis = .vertical
    }

    /// `34.1` by default.
    public var paddingTop: CGFloat = .zero {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "containerStackViewTop", constant: paddingTop)
        }
    }

    /// `34.1` by default.
    public var paddingBottom: CGFloat = .zero {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "containerStackViewBottom", constant: -paddingTop)
        }
    }

    private let alertImageView = UIImageView().then {
        //$0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        //$0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        $0.contentMode = .scaleAspectFit
    }

    private var alertImageSubView: UIView?

    private let titleLabel = UILabel().then {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }

    private let messageLabel = UILabel().then {
        $0.numberOfLines = .zero
        $0.textAlignment = .center
    }

    // MARK: - Public Properties

    public var style: AlertStyle = .custom {
        didSet { setAlertStyle() }
    }

    /// The alert image.
    public var alertImage: UIImage? {
        get { alertImageView.image }
        set { setAlertImage(newValue) }
    }

    /// `34.1` by default.
    @available(*, deprecated, message: "Use `paddingTop` instead.")
    public var alertImageViewPaddingTop: CGFloat = 0 {
        didSet { paddingTop = alertImageViewPaddingTop }
    }

    /// `51.8` by default.
    public var alertImageViewHeight: CGFloat = 0 {
        didSet {
            alertImageView.updateConstraint(identifier: "alertImageViewHeight", constant: alertImageViewHeight)
        }
    }

    /// `51.8` by default.
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

    ///  `34.1` by default.
    public var titleLabelPaddingTop: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "titleLabelTop", constant: titleLabelPaddingTop)
        }
    }

    ///  `12` by default.
    @available(*, deprecated, message: "Use `messageLabelPaddingTop` instead.")
    public var titleLabelPaddingBottom: CGFloat = 0 {
        didSet { messageLabelPaddingTop = titleLabelPaddingBottom }
    }

    ///  `24` by default.
    public var titleLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "titleLabelLeft", constant: titleLabelPaddingLeft)
        }
    }

    ///  `24` by default.
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

    /// `12` by default.
    public var messageLabelPaddingTop: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "messageLabelTop", constant: messageLabelPaddingTop)
        }
    }

    /// `32` by default.
    @available(*, deprecated, message: "Use `paddingBottom` instead.")
    public var messageLabelPaddingBottom: CGFloat = 0 {
        didSet { paddingBottom = messageLabelPaddingBottom }
    }

    /// `32` by default.
    public var messageLabelPaddingLeft: CGFloat = 0 {
        didSet {
            containerStackView.updateSubViewConstraint(identifier: "messageLabelLeft", constant: messageLabelPaddingLeft)
        }
    }

    /// `32` by default.
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
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(alertImageView)
        containerStackView.addArrangedSubview(titleLabel,
                                              withMargin: Layout.titleLabelInsets,
                                              identifier: "titleLabel")
        containerStackView.addArrangedSubview(messageLabel,
                                              withMargin: Layout.messageLabelInsets,
                                              identifier: "messageLabel")

        addConstraints()
    }

    private func addConstraints() {
        containerStackView.anchor(top: topAnchor,
                                  paddingTop: Layout.containerStackViewPaddingTop,
                                  bottom: bottomAnchor,
                                  paddingBottom: Layout.containerStackViewPaddingBottom,
                                  left: leftAnchor,
                                  right: rightAnchor,
                                  identifier: "containerStackView")
        
        // errorImage
        alertImageView.anchor(width: Layout.errorImageSize,
                              height: Layout.errorImageSize,
                              identifier: "alertImageView")
        alertImageView.solveSimultaneouslyConstraintsError("alertImageViewWidth")
    }

    private func setAlertStyle() {
        guard style != .custom,
              alertImage == nil else {
            return
        }
        if case .success = style {
            if #available(iOS 13.0, *) {
                alertImage = .init(systemName: "checkmark.circle.fill")
                alertImageView.tintColor = .systemGreen
            }
        }
        if case .failure = style {
            if #available(iOS 13.0, *) {
                alertImage = .init(systemName: "x.circle.fill")
                alertImageView.tintColor = .systemRed
            }
        }
    }

    private func setAlertImage(_ image: UIImage?) {
        alertImageView.image = image
        hideOrShowImageIfNecessary()
    }

    private func hideOrShowImageIfNecessary() {
        guard alertImageView.image == nil, alertImageSubView == nil else {
            if imageIsHidden { showImage() }
            return
        }
        hideImage()
    }

    private func showImage() {
        imageIsHidden = false
        alertImageView.isHidden = false
    }

    private func hideImage() {
        imageIsHidden = true
        alertImageView.isHidden = true
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
                if titleIsHidden { showTitle() }
                return
            }
            hideTitle()
        } else if let titleAttributedText = titleLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                if titleIsHidden { showTitle() }
                return
            }
            hideTitle()
        } else {
            hideTitle()
        }
    }

    private func showTitle() {
        titleLabel.superview?.isHidden = false
        titleIsHidden = false
    }

    private func hideTitle() {
        titleLabel.superview?.isHidden = true
        titleIsHidden = true
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
                if messageIsHidden { showMessage() }
                return
            }
            hideMessage()
        } else if let titleAttributedText = messageLabel.attributedText {
            guard titleAttributedText.string.isEmpty else {
                if messageIsHidden { showMessage() }
                return
            }
            hideMessage()
        } else {
            hideMessage()
        }
    }

    private func showMessage() {
        messageIsHidden = false
        messageLabel.superview?.isHidden = false
    }

    private func hideMessage() {
        messageIsHidden = true
        messageLabel.superview?.isHidden = true
    }

}
