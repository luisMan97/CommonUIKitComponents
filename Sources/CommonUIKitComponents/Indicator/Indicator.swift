//
//  Indicator.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 24/02/23.
//

import UIKit

public class Indicator {

    // MARK: - Private UI Properties

    private var blurImg = UIImageView()
    private var indicator = UIActivityIndicatorView()

    // MARK: - Public Properties

    public static let shared = Indicator()
    public var timeToForceClose: Double = .zero

    // MARK: - Private Properties

    private var isShowing = false
    private var timer: Timer?

    // MARK: - Initializers

    private init() {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = .black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        if #available(iOS 13.0, *) { indicator.style = .large }
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .white
    }

    // MARK: - Public Methods

    public func showIndicator() {
        DispatchQueue.main.async { [self] in
            guard let keyWindow = UIWindow.key else { return }
            isShowing = true
            keyWindow.addSubview(blurImg)
            keyWindow.addSubview(indicator)
            addTimer()
        }
    }

    public func hideIndicator() {
        DispatchQueue.main.async { [self] in
            isShowing = false
            timer?.invalidate()
            blurImg.removeFromSuperview()
            indicator.removeFromSuperview()
        }
    }

    // MARK: - Private Methods

    private func addTimer() {
        guard timeToForceClose > 0 else {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: timeToForceClose,
                                          target: self,
                                          selector: #selector(fireTimer),
                                          userInfo: nil,
                                          repeats: true)
    }

    // MARK: - Private @objc Methods

    @objc
    private func fireTimer() {
        if isShowing { hideIndicator() }
    }

}

