//
//  BaseLoadingVeiw.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

final class BaseLoadingVeiw: BaseView {

	// MARK: - Private properties

	private let stackView = UIStackView()
	private let title = BaseLabel(with: .title)
	private let subtitle = BaseLabel(with: .subtitle)
	private let button = BaseButton()
	private let indicator = UIActivityIndicatorView()
	
	var animationDuration: Double = 0.3

	init() {
		super.init(frame: .zero)
		configureView()
	}

	override func setupView() {
		[indicator, stackView, title, subtitle, button].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		addSubview(stackView)

		[indicator, title, subtitle, button].forEach {
			stackView.addArrangedSubview($0)
		}
		super.setupView()
	}

	override func setupConstraints() {
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			stackView.topAnchor.constraint(equalTo: topAnchor),
			stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}

	func show() {
		UIView.animate(withDuration: animationDuration) { [weak self] in
			self?.alpha = 1
		}
		indicator.startAnimating()
	}

	func hide() {
		UIView.animate(withDuration: animationDuration) { [weak self] in
			self?.alpha = 0
		} completion: { [weak self] isFinished in
			if isFinished { self?.indicator.stopAnimating() }
		}
	}

	func set(_ title: String? = nil,
			 _ subtitle: String? = nil,
			 buttonTitle: String? = nil,
			 action: (() -> Void)? = nil) {
		self.title.text = title
		self.subtitle.text = subtitle
		self.button.setTitle(buttonTitle, for: .normal)
		self.title.isHidden = title == nil
		self.subtitle.isHidden = subtitle == nil
		self.button.isHidden = buttonTitle == nil
	}
}

private extension BaseLoadingVeiw {
	func configureView() {
		alpha = 0
	}
}
