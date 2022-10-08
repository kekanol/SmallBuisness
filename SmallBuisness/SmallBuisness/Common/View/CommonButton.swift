//
//  CommonButton.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

final class CommonButton: UIButton {

	var isLoading: Bool = false {
		willSet {
			if newValue {
				presentIsLoading()
			} else if newValue != isLoading {
				presentNormal()
			}
		}
	}

	private let style: CommonButtonStyle
	private lazy var spinner: Spinner = {
		let size = CGSize(width: frame.height - 8, height: frame.height - 8)
		let origin = CGPoint(x: bounds.midX - size.height / 2, y: bounds.midY - size.height / 2)
		print(origin)
		print(size)
		let spinnerFrame = CGRect(origin: origin, size: size)
		let spinner = Spinner(frame: spinnerFrame, tintColor: style.textColorNormal)
		addSubview(spinner)
		return spinner
	}()

	override var isEnabled: Bool {
		willSet {
			backgroundColor = newValue ? style.backgroundColorNormal : style.backgroundColorDisabled
		}
	}

	override var isHighlighted: Bool {
		willSet {
			backgroundColor = newValue ? style.backgroundColorSelected : style.backgroundColorNormal
		}
	}

	init(_ style: CommonButtonStyle) {
		self.style = style
		super.init(frame: .zero)
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func setTitle(_ title: String?, for state: UIControl.State) {
		super.setTitle(title, for: state)
		titleLabel?.font = .standart(style: .semibold, of: 14)
	}
}

private extension CommonButton {
	func setupView() {
		setTitleColor(style.textColorNormal, for: .normal)
		setTitleColor(style.textColorSelected, for: .highlighted)
		setTitleColor(style.textColorDisabled, for: .disabled)
		backgroundColor = style.backgroundColorNormal
		layer.cornerRadius = 8
		clipsToBounds = true
	}

	func presentIsLoading() {
		isUserInteractionEnabled = false
		spinner.startAnimating()
		UIView.animate(withDuration: 0.15) { [weak self] in
			self?.titleLabel?.alpha = 0
			self?.imageView?.alpha = 0
		}
	}

	func presentNormal() {
		isUserInteractionEnabled = true
		spinner.endAnimating()
		UIView.animate(withDuration: 0.15) { [weak self] in
			self?.titleLabel?.alpha = 1
			self?.imageView?.alpha = 1
		}
	}
}

enum CommonButtonStyle {
	case primary
	case secondary
	case transparent

	var backgroundColorNormal: UIColor {
		switch self {
		case .primary:
			return .primary
		case .secondary:
			return .secondary
		case .transparent:
			return .clear
		}
	}

	var backgroundColorSelected: UIColor {
		switch self {
		case .primary:
			return .primarySelected
		case .secondary:
			return .secondarySelected
		case .transparent:
			return .tetrarySelected
		}
	}

	var backgroundColorDisabled: UIColor {
		switch self {
		case .primary:
			return .primaryDisabled
		case .secondary:
			return .secondaryDisabled
		case .transparent:
			return .clear
		}
	}

	var textColorNormal: UIColor {
		switch self {
		case .primary:
			return .white
		case .secondary, .transparent:
			return .textPurple
		}
	}

	var textColorSelected: UIColor {
		switch self {
		case .primary:
			return .white
		case .secondary:
			return .textPurple
		case .transparent:
			return .primarySelected
		}
	}

	var textColorDisabled: UIColor {
		return .textPurpleDisabled
	}
}
