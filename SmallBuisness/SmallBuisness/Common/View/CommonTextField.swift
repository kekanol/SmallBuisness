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
	var keyBoardType: UIKeyboardType = .default {
		didSet { textField.keyboardType = keyBoardType }
	}
	var delegate: CommonTextFieldDelegate?
	var text: String?
	var textChanged: ((String?) -> Void)?

	private(set) var status: Status = .base
	private let isPassword: Bool

	let textField = UITextField()
	private let button = UIButton()
	private lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [textField, button])
		stack.axis = .horizontal
		return stack
	}()

	init(isPassword: Bool = false) {
		self.isPassword = isPassword
		super.init(frame: .zero)
		setupView()
		configureView()
		updateAppearance()
		let gr = UITapGestureRecognizer(target: self, action: #selector(setActive))
		addGestureRecognizer(gr)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func validationEnded(with result: Status) {
		status = result
		updateAppearance()
	}

	func setText(_ text: String) {
		
	}

	@objc
	func setActive() {
		_ = textField.becomeFirstResponder()
	}
}

private extension CommonTextField {
	func setupView() {
		addSubview(stack)

		stack.snp.makeConstraints { make in
			make.leading.top.bottom.trailing.equalToSuperview().inset(16)
		}

		button.snp.makeConstraints { make in
			make.width.height.equalTo(16)
		}
	}

	func configureView() {
		clipsToBounds = true
		layer.borderWidth = 2
		layer.cornerRadius = 8

		textField.delegate = self
		textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
		textField.isSecureTextEntry = isPassword
		textField.font = .standart(style: .regular, of: 14)

		let image: UIImage = isPassword ? (textField.isSecureTextEntry ? .eyeClosed : .eyeOpened) : .ban
		button.setImage(image, for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
		button.isHidden = isPassword ? false : status != .active
	}

	@objc
	func textDidChange(_ sender: UITextField) {
		text = textField.text
		textChanged?(text)
	}

	@objc
	func buttonAction() {
		if isPassword {
			textField.isSecureTextEntry.toggle()
			let image: UIImage = textField.isSecureTextEntry ? .eyeClosed : .eyeOpened
			button.setImage(image, for: .normal)
			return
		}
		textField.text = nil
		text = nil
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
