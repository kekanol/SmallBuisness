//
//  OrView.swift
//  SmallBuisness
//
//  Created by Константин on 04.10.2022.
//

import UIKit

final class OrView: UIView {
	private let label = UILabel()
	private let left = UIView()
	private let right = UIView()

	init() {
		super.init(frame: .zero)

		backgroundColor = .white
		label.text = "или"
		label.font = .standart(style: .regular, of: 14)
		label.textColor = .textSecondary

		left.backgroundColor = .elementLine
		right.backgroundColor = .elementLine

		[label, left, right].forEach {
			addSubview($0)
		}
		label.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.equalTo(26)
			make.height.equalTo(10)
		}
		left.snp.makeConstraints { make in
			make.leading.centerY.equalToSuperview()
			make.trailing.equalTo(label.snp.leading)
			make.height.equalTo(1)
		}
		right.snp.makeConstraints { make in
			make.trailing.centerY.equalToSuperview()
			make.leading.equalTo(label.snp.trailing)
			make.height.equalTo(1)
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
