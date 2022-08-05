//
//  ProgressRing.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class ProgressRing: UIView {

	private let foregroundRing = UIView()

	var currentPersent: Float {
		didSet {
			udpateForegroundRing()
		}
	}

	var animationDuration: Double = 0.3

	init(_ initialPersent: Float = 0) {
		currentPersent = initialPersent
		super.init(frame: .zero)
		setBackgroundRing()
		addForeground()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func addForeground() {
		foregroundRing.translatesAutoresizingMaskIntoConstraints = false
		addSubview(foregroundRing)
		foregroundRing.snp.makeConstraints { make in
			make.leading.top.trailing.bottom.equalToSuperview()
		}

		foregroundRing.layer.backgroundColor = UIColor.white.cgColor
	}

	private func setBackgroundRing() {
		let endAngle = Float.pi * 2
		let maskLayer = CAShapeLayer()
		let path = UIBezierPath()
		path.move(to: CGPoint(x: frame.width / 2, y: 2))
		path.addArc(withCenter: center, radius: (frame.width - 2) / 2, startAngle: 0, endAngle: CGFloat(endAngle), clockwise: true)
		path.lineWidth = 4
		maskLayer.path = path.cgPath
		layer.mask = maskLayer
		layer.backgroundColor = UIColor.gray.cgColor
	}

	private func udpateForegroundRing() {
		let endAngle = Float.pi * 2 / 360 * currentPersent
		let maskLayer = CAShapeLayer()
		let path = UIBezierPath()
		path.move(to: CGPoint(x: frame.width / 2, y: 2))
		path.addArc(withCenter: center, radius: (frame.width - 2) / 2, startAngle: 0, endAngle: CGFloat(endAngle), clockwise: true)
		path.lineWidth = 4
		maskLayer.path = path.cgPath

		UIView.animate(withDuration: animationDuration, delay: 0) { [weak self] in
			self?.foregroundRing.layer.mask = maskLayer
		}
	}
}
