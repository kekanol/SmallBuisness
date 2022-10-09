//
//  SnackBar.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class SnackBar: UIView {
	private let duration = 2.0
	private let message: String
	private let bottomOffset: CGFloat
	private let keyBoardHeight: CGFloat
	private let isError: Bool

	init(message: String, isError: Bool, bottomOffset: CGFloat = 60, keyBoardHeight: CGFloat) {
		self.message = message
		self.isError = isError
		self.bottomOffset = bottomOffset
		self.keyBoardHeight = keyBoardHeight
		super.init(frame: .zero)
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func present(on vc: UIViewController?) {
		vc?.view.addSubview(self)
		let yCoordinate = UIConstants.screenHeight - bottomOffset - keyBoardHeight - 48
		let origin = CGPoint(x: 24, y: yCoordinate)
		UIView.animate(withDuration: 0.15) {
			self.frame.origin = origin
		} completion: { _ in
			DispatchQueue.main.asyncAfter(deadline: .now() + self.duration) {
				self.hide()
			}
		}
	}

	private func setupView() {
		let size = CGSize(width: UIConstants.screenWidth - 48, height: 48)
		frame = CGRect(origin: CGPoint(x: 24, y: UIConstants.screenHeight), size: size)
		backgroundColor = isError ? .error : .secondary
		layer.cornerRadius = 8
		let labelFrame = CGRect(origin: CGPoint(x: 16, y: 16), size: CGSize(width: frame.width - 32, height: 16))
		let label = UILabel(frame: labelFrame)
		label.text = message
		label.font = .standart(style: .medium, of: 12)
		label.textColor = .textPrimary
		addSubview(label)
	}

	private func hide() {
		UIView.animate(withDuration: 0.15) {
			self.frame.origin.y = UIScreen.main.bounds.height
		} completion: { _ in
			self.removeFromSuperview()
		}
	}
}
