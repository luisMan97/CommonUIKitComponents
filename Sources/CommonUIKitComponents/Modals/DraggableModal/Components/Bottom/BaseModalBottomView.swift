//
//  BaseModalBottomView.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

class BaseModalBottomView: UIView {

    lazy var gradientView = UIView(frame: .zero).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        addSubview($0)
    }

    var colors: [UIColor] = []

    init(frame: CGRect = .zero, colors: [UIColor]? = nil) {
        super.init(frame: frame)
        self.colors = colors ?? [
            .white.withAlphaComponent(0.1),
            .white.withAlphaComponent(0.3),
            .white.withAlphaComponent(0.9),
            .white
        ]

        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        self.colors = [
            .white.withAlphaComponent(0.1),
            .white.withAlphaComponent(0.3),
            .white.withAlphaComponent(0.9),
            .white
        ]

        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        Gradient.setGradient(in: gradientView.layer,
                             colors: colors,
                             direction: .bottom)
    }

    func viewDidLoad() {
        setupAppearance()
    }

    func animateAppear(_ appeared: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.gradientView.alpha = appeared ? 1.0 : 0.0
        })
    }

    func setupView() {
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: topAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        Gradient.setGradient(in: gradientView.layer,
                             colors: colors,
                             direction: .bottom)
    }

    func setupAppearance() {
        backgroundColor = .clear
    }
}
