//
//  BaseLabel.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

class BaseLabel: UILabel {

	// MARK: - Public properties

	var style: LabelTextStyle = .title {
		didSet {
			update(for: style)
		}
	}

	init(with style: LabelTextStyle) {
		super.init(frame: .zero)
		self.style = style
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Private methods

	private func update(for style: LabelTextStyle) {
		switch style {
		case .title:
			font = UIFont.systemFont(ofSize: 20, weight: .bold)
			textColor = .black
		case .subtitle:
			font = UIFont.systemFont(ofSize: 16, weight: .medium)
			textColor = .gray
		case .body:
			font = UIFont.systemFont(ofSize: 12, weight: .regular)
			textColor = .black
		case .secondary:
			font = UIFont.systemFont(ofSize: 12, weight: .regular)
			textColor = .lightGray
		}
	}
}

enum LabelTextStyle {
	case title
	case subtitle
	case body
	case secondary
}
