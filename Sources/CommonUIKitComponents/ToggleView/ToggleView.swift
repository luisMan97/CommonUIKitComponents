//
//  ToggleView.swift
//  Pods-UIKitCommons_Example
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public class ToggleView: BaseUIView {
    
    private let containerStackView = UIStackView().then {
        $0.distribution = .fillProportionally
    }
    
    private lazy var label = UILabel().then {
        $0.numberOfLines = 0
    }
    
    private lazy var toggle = UISwitch().then {
        $0.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
    }
    
    // MARK: - Public Properties
    
    public var isOn: Bool {
        get { toggle.isOn }
        set { setIsOn(newValue) }
    }
    
    public var labelText: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    // MARK: - Public Closure Properties
    
    public var switchCompletion: GenericCompletionHandler<Bool>?
    
    public override func configureView() {
        super.configureView()
        addSubViews()
    }
    
    private func addSubViews() {
        containerStackView.fixInView(self)
        
        containerStackView.addArrangedSubview(label, withMargin: .zero)
        containerStackView.addArrangedSubview(toggle)
        
        toggle.anchor(width: 51)
    }
    
    private func setIsOn(_ isOn: Bool) {
        toggle.isOn = isOn
        switchCompletion?(isOn)
    }
    
    @objc
    private func handleSwitchAction(sender: UISwitch) {
        switchCompletion?(sender.isOn)
    }
}

