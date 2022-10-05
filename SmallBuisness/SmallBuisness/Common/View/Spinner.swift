//
//  Spinner.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

final class Spinner: UIView {

	private var spinLayer: CALayer!

	init(frame: CGRect, tintColor: UIColor) {
		super.init(frame: frame)
		let bounds = CGRect(origin: CGPoint(), size: frame.size)
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		spinLayer = ProgressRing(bounds: bounds, position: center, fromColor: .clear, toColor: tintColor, linewidth: 3, toValue: 1)
		layer.addSublayer(spinLayer)
		alpha = 1
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func startAnimating() {
		UIView.animate(withDuration: 0.15) { [weak self] in
			self?.alpha = 1
		}
		let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
		rotationAnimation.fromValue = 0.0
		rotationAnimation.toValue = Float.pi * 2.0
		rotationAnimation.duration = 0.4
		rotationAnimation.repeatCount = .infinity
		spinLayer.add(rotationAnimation, forKey: "rotation")
	}

	func endAnimating() {
		UIView.animate(withDuration: 0.15) { [weak self] in
			self?.alpha = 0
		} completion: { [weak self] isFinished in
			guard isFinished else { return }
			self?.spinLayer.removeAllAnimations()
		}
	}
}
