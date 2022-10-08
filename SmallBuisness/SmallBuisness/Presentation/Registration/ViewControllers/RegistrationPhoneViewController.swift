//
//  RegistrationPhoneViewController.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

final class RegistrationPhoneViewController: CommonViewController {
	private let presenter: RegistrationPresenter
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Добавьте номер телефона"
		label.font = .standart(style: .bold, of: 20)
		label.textColor = .textPrimary
		return label
	}()
	private lazy var subtitleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 3
		label.text = "При помощи номера телефона Вы сможете восстановить аккаунт при необходимости"
		label.font = .standart(style: .regular, of: 14)
		label.textColor = .textSecondary
		return label
	}()
	private let textField: PhoneTextField = {
		let textField = PhoneTextField(isPassword: false)
		textField.placeholder = "Номер телефона"
		return textField
	}()
	private lazy var button: CommonButton = {
		let button = CommonButton(.primary)
		button.isEnabled = false
		button.setTitle("Далее", for: .normal)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
		return button
	}()

	init(presenter: RegistrationPresenter) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		textField.textChanged = { [weak self] text in
			self?.button.isEnabled = text != nil
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
		textField.setActive()
	}

	override func handleTap(sender: UITapGestureRecognizer? = nil) {}
}

private extension RegistrationPhoneViewController {
	func setupView() {
		view.backgroundColor = .elementaryBackground
		[titleLabel, subtitleLabel, textField, button].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview($0)
		}
		titleLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(24)
			make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
			make.height.equalTo(24)
		}
		subtitleLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
		}
		textField.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(subtitleLabel.snp.bottom).offset(24)
			make.height.equalTo(50)
		}
		button.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(textField.snp.bottom).offset(40)
			make.height.equalTo(40)
		}
	}

	@objc
	func buttonAction() {
		guard let text = textField.text else {
			textField.validationEnded(with: .error(message: "Введите телефон"))
			return
		}
		button.isLoading = true
		presenter.askIfCanContinue(with: .phone, text: text) { [weak self] result in
			guard let self = self else { return }
			self.button.isLoading = false
			if result {
				self.textField.validationEnded(with: .correct)
			} else {
				self.textField.validationEnded(with: .error(message: "Неверный номер телефона"))
			}
		}
	}
}
