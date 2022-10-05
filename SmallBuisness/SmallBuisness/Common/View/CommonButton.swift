//
//  CommonButton.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

final class CommonButton: UIButton {

	private let style: CommonButtonStyle

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
