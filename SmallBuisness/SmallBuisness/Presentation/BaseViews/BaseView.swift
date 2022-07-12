//
//  BaseView.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

class BaseView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupView() {
		addSubviews()
	}

	func addSubviews() {
		setupConstraints()
	}

	func setupConstraints() {
		
	}
}
