//
//  AlertView.swift
//  CommonUIKit
//
//  Created by Jorge Luis Rivera Ladino on 30/08/22.
//

public class AlertView: BaseUIView {

    typealias Layout = AlertLayout

    // MARK: - Private UI Properties

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

    /// The alert image.
    public var alertImage: UIImage? {
        get { alertImageView.image }
        set { alertImageView.image = newValue }
    }
    
    public var alertImageViewPaddingTop: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "alertImageViewTop", constant: alertImageViewPaddingTop)
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
        set { titleLabel.text = newValue }
    }

    /// The title attributed text in NSAttributedString.
    public var titleAttributedText: NSAttributedString? {
        get { titleLabel.attributedText }
        set { titleLabel.attributedText = newValue }
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
            updateConstraint(identifier: "titleLabelTop", constant: titleLabelPaddingTop)
        }
    }
    
    public var titleLabelPaddingLeft: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "titleLabelLeft", constant: titleLabelPaddingLeft)
        }
    }
    
    public var titleLabelPaddingRight: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "titleLabelRight", constant: -titleLabelPaddingRight)
        }
    }
    
    /// The message text in string.
    public var messageText: String? {
        get { messageLabel.text ?? "" }
        set { messageLabel.text = newValue }
    }

    /// The message attributed text in NSAttributedString.
    public var messageAttributedText: NSAttributedString? {
        get { messageLabel.attributedText }
        set { messageLabel.attributedText = newValue }
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
            updateConstraint(identifier: "messageLabelTop", constant: messageLabelPaddingTop)
        }
    }
    
    public var messageLabelPaddingBottom: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "messageLabelBottom", constant: -messageLabelPaddingBottom)
        }
    }
    
    public var messageLabelPaddingLeft: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "messageLabelLeft", constant: messageLabelPaddingLeft)
        }
    }
    
    public var messageLabelPaddingRight: CGFloat = 0 {
        didSet {
            updateConstraint(identifier: "messageLabelRight", constant: -messageLabelPaddingRight)
        }
    }

    // MARK: - Override Methods

    public override func configureView() {
        super.configureView()
        addViews()
    }

    // MARK: - Private Methods

    private func addViews() {
        addSubview(alertImageView)
        addSubview(titleLabel)
        addSubview(messageLabel)

        addConstraints()
    }

    private func addConstraints() {
        // errorImage
        alertImageView.anchor(top: topAnchor,
                              paddingTop: Layout.errorImagePaddingTop,
                              width: Layout.errorImageWidth,
                              height: Layout.errorImageHeight,
                              centerX: self,
                              identifier: "alertImageView"
        )

        // titleLabel
        titleLabel.anchor(top: alertImageView.bottomAnchor,
                          paddingTop: Layout.titleLabelPaddingTop,
                          left: leftAnchor,
                          paddingLeft: Layout.titleLabelPaddingLeft,
                          right: rightAnchor,
                          paddingRight: Layout.titleLabelPaddingRight,
                          identifier: "titleLabel"
        )

        // messageLabel
        messageLabel.anchor(top: titleLabel.bottomAnchor,
                            paddingTop: Layout.messageLabelPaddingTop,
                            bottom: bottomAnchor,
                            paddingBottom: Layout.messageLabelPaddingBottom,
                            left: leftAnchor,
                            paddingLeft: Layout.messageLabelPaddingLeft,
                            right: rightAnchor,
                            paddingRight: Layout.messageLabelPaddingRight,
                            identifier: "messageLabel"
        )
    }
}

