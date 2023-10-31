//
//  SideView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 24/02/23.
//

import UIKit

public class SideView: BaseUIView {

    // MARK: - Private UI Properties

    private lazy var backgroundView = UIView().then {
       // $0.isHidden = false
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                       action: #selector(closeSideMenu)))
    }

    private let contentView = UIView().then {
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.layer.shadowOpacity = 2
        $0.layer.shadowRadius = 7
    }

    // MARK: - Public Properties

    public var didEndClose: Observable<Void> { didEndCloseMutableObservable }

    // MARK: - Private Properties

    private let didEndCloseMutableObservable: MutableObservable<Void> = MutableObservable<Void>()

    // MARK: - Override Methods

    public override func configureView() {
        super.configureView()
        addSubViews()
        backgroundColor = .clear
    }

    // MARK: - Public Methods
    
    public func addContentView(_ view: UIView) {
        view.fixInView(contentView)
    }

    public func showWithEffect() {
        contentView.isHidden = false
        if let contentViewLeftConstraint = constraintWith(identifier: "contentViewLeft") {
            contentViewLeftConstraint.constant = .zero
        }
        if let backgroundViewLeftConstraint = constraintWith(identifier: "backgroundViewRight") {
            backgroundViewLeftConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.4,
                       delay: 0.2,
                       animations: { [self] in
            backgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        })
        animate(withDuration: 0.3)
    }

    // MARK: - Public @objc Methods

    @objc
    public func closeSideMenu() {
        if let contentViewLeftConstraint = constraintWith(identifier: "contentViewLeft") {
            contentViewLeftConstraint.constant = -UIScreen.main.bounds.width
        }
        if let backgroundViewRightConstraint = constraintWith(identifier: "backgroundViewRight") {
            backgroundViewRightConstraint.constant = -UIScreen.main.bounds.width
        }
        backgroundView.backgroundColor = .black.withAlphaComponent(0)
        animate(withDuration: 0.1, completion: { [self] _ in
            didEndCloseMutableObservable.postValue(())
            contentView.isHidden = true
        })
    }

    // MARK: - Private Methods

    private func addSubViews() {
        addSubview(backgroundView)
        addSubview(contentView)
        
        addConstraits()
    }

    private func addConstraits() {
        contentView.anchor(top: topAnchor,
                           bottom: bottomAnchor,
                           left: leftAnchor,
                           paddingLeft: -UIScreen.main.bounds.width,
                           width: UIScreen.main.bounds.width - 90,
                           identifier: "contentView")

        backgroundView.anchor(top: contentView.topAnchor,
                              bottom: contentView.bottomAnchor,
                              left: contentView.leftAnchor,
                              right: rightAnchor,
                              paddingRight: UIScreen.main.bounds.width,
                              identifier: "backgroundView")
    }

}
