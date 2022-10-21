//
//  StepperView.swift
//  Pods-UIKitCommons_Example
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public class StepperView: BaseUIView {
    
    private let containerStackView = UIStackView().then {
        $0.distribution = .fillProportionally
    }
    
    private lazy var label = UILabel().then {
        $0.numberOfLines = 0
    }
    
    private lazy var stepper = UIStepper().then {
        $0.addTarget(self, action: #selector(handleSteperAction), for: .valueChanged)
    }
    
    // MARK: - Public Properties
    
    public var labelText: String? {
        get { label.text }
        set { label.text = newValue }
    }
    
    public var value: Double {
        get { stepper.value }
        set { stepper.value = newValue }
    }
    
    // MARK: - Public Closure Properties
    
    public var switchCompletion: GenericCompletionHandler<Double>?
    
    public override func configureView() {
        super.configureView()
        addSubViews()
    }
    
    private func addSubViews() {
        containerStackView.fixInView(self)
        
        containerStackView.addArrangedSubview(label, withMargin: .zero)
        containerStackView.addArrangedSubview(stepper)
        
        stepper.anchor(width: 95)
    }
    
    @objc
    private func handleSteperAction(sender: UIStepper) {
        switchCompletion?(sender.value)
    }
}
