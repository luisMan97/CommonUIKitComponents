//
//  ModalTagsFactory.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import CommonUIKitComponents
import UIKit

enum ModalTagsFactory {
    
    static func showModalTags(originController: UIViewController?,
                              tags: [Tag]
    ) {
        let dataSource = ModalTagsDataSource(data: tags).then {
            $0.collectionView?.reloadData()
        }
        
        let bottomView = PromotionsFilterFooterView()
        
        var config = DraggableModalConfig(header: configModalHeader(),
                                          bottom: bottomView,
                                          dataSource: dataSource)
        config.higherProportion = 0.9
        config.isExpandable = true
        config.generateFeedback = false
        config.refreshLayoutAfterUpdate = true
       
        let component = DraggableModalComponent(config: config)
        component.present(over: originController)
        
        bottomView.applyChangesObservable.observe {
            component.dismiss()
        }
    }
    
    static func configModalHeader() -> BaseModalHeaderComponent {
        let toptitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.italicSystemFont(ofSize: 14),
            .foregroundColor: UIColor.contentA
        ]
        
        let toptitleAtt = NSAttributedString(string: "Top title",
                                          attributes: toptitleAttributes)
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 26),
            .foregroundColor: UIColor.contentA
        ]
        
        let titleAtt = NSAttributedString(string: "Tags large title",
                                          attributes: titleAttributes)
        
        let subTitleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.contentA
        ]
        
        let subTitleAttribute = NSAttributedString(string: "Tags description.",
                                                   attributes: subTitleAttributes)
        
        let contentInsets = UIEdgeInsets(top: .spacing(4),
                                         left: .spacing(4),
                                         bottom: .spacing(4),
                                         right: .spacing(4))
                
        let headerConfig = BaseModalHeaderConfig(title: titleAtt,
                                                 subtitle: subTitleAttribute,
                                                 toptitle: toptitleAtt,
                                                 contentInsets: contentInsets,
                                                 style: .large,
                                                 decoratorColor: .red)
        
        let headerComponent = BaseModalHeaderComponent(config: headerConfig)
        
        return headerComponent
    }
}

class PromotionsFilterFooterView: UIView, BottomViewComponent {
    
    private lazy var buttonComponent: BaseButtonComponent = {
        let config = ButtonConfig(buttonColor: .positive,
                                  iconState: .none,
                                  initialState: .enable,
                                  frame: .zero,
                                  size: .medium,
                                  font: UIFont.systemFont(ofSize: 12),
                                  title: "Aplicar")
        return BaseButtonComponent(config: config)
    }()
    
    var base: UIView { return self }
    var height: CGFloat {
        let window = UIApplication.shared.keyWindow
        let bottomPadding = window?.safeAreaInsets.bottom ?? 0.0
        return 80 + bottomPadding
    }

    var applyChangesObservable: Observable<Void> {
        applyChangesMutableObservable
    }
    
    private let applyChangesMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
   
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        transform = CGAffineTransform(translationX: 0, y: height)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.transform = .identity
            })
        })
    }
    
    func animateAppear(_ appeared: Bool) {}
    
    private func setup() {
        setupConstraints()
        bind()
    }
    
    private func setupConstraints() {
        let button = buttonComponent.getBaseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(button)
        
        button
            .leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: .spacing(12))
            .isActive = true
        button
            .trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -.spacing(12))
            .isActive = true
        button
            .centerYAnchor
            .constraint(equalTo: centerYAnchor)
            .isActive = true
        button
            .heightAnchor
            .constraint(equalToConstant: 56)
            .isActive = true
    }
    
    private func bind() {
        buttonComponent.buttonTapper().observe { [weak self] in
            self?.applyChangesMutableObservable.postValue(())
        }
            /*.throttle(.seconds(2), latest: false, scheduler: MainScheduler.instance)
            .bind(to: applyChangesSubject)
            .disposed(by: disposeBag)*/
    }
}
