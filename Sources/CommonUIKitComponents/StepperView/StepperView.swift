//
//  StepperView.swift
//  Pods-UIKitCommons_Example
//
//  Created by Jorge Luis Rivera Ladino on 8/09/22.
//

import UIKit

public class StepperView: BaseUIView {

    private let containerStackView = UIStackView().then {
        $0.alignment = .top
        $0.distribution = .fill
    }

    private lazy var label = UILabel().then {
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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

        containerStackView.addArrangedSubview(label)
        containerStackView.addArrangedSubview(stepper)        
    }

    @objc
    private func handleSteperAction(sender: UIStepper) {
        switchCompletion?(sender.value)
    }
}
