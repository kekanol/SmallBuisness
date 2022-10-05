//
//  CommonTextField.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

protocol CommonTextFieldDelegate {

}

class CommonTextField: UIView {

	var placeholder: String = "" {
		didSet { textField.placeholder = placeholder }
	}
	var delegate: CommonTextFieldDelegate?
	var text: String?

	private(set) var status: Status = .base
	private let isPassword: Bool

	private let textField = UITextField()
	private let buttonClear = UIButton()
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [textField, buttonClear])
		stack.axis = .horizontal
		return stack
	}()

	init(isPassword: Bool = false) {
		self.isPassword = isPassword
		super.init(frame: .zero)
		setupView()
		configureView()
		updateAppearance()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setActive() {
		_ = textField.becomeFirstResponder()
	}

	func validationEnded(with result: Status) {
		status = result
		updateAppearance()
	}
}

private extension CommonTextField {
	func setupView() {
		addSubview(stack)

		stack.snp.makeConstraints { make in
			make.leading.top.bottom.trailing.equalToSuperview().inset(16)
		}

		buttonClear.snp.makeConstraints { make in
			make.width.height.equalTo(16)
		}
	}

	func configureView() {
		textField.delegate = self
		textField.addTarget(self, action: #selector(textDidChange(_:)), for: .valueChanged)
		textField.isSecureTextEntry = isPassword
		clipsToBounds = true
		layer.borderWidth = 2
		layer.cornerRadius = 8
		textField.font = .standart(style: .regular, of: 14)
		buttonClear.setImage(isPassword ? .eyeClosed : .ban, for: .normal)
	}

	func updateAppearance() {
		switch status {
		case .error:
			layer.borderColor = UIColor.error.cgColor
		case .active:
			layer.borderColor = UIColor.primary.cgColor
		case .correct:
			layer.borderColor = UIColor.accept.cgColor
		case .disabled, .base:
			layer.borderColor = UIColor.elementLine.cgColor
		}
		buttonClear.isHidden = isPassword ? false : status != .active
	}

	@objc
	func textDidChange(_ sender: UITextField) {
		text = textField.text
	}
}

extension CommonTextField: UITextFieldDelegate {

	func textFieldDidBeginEditing(_ textField: UITextField) {
		status = .active
		updateAppearance()
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		status = .base
		UIView.animate(withDuration: 0.15) { [weak self] in
			self?.updateAppearance()
		}
	}
}

extension CommonTextField {

	enum Status: Equatable {
		case error(message: String)
		case active
		case correct
		case disabled
		case base
	}
}
