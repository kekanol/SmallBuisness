//
//  AuthViewController.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

protocol AuthViewControllerProtocol: UIViewController {
	func present(for state: AuthState)
}

final class AuthViewController: CommonViewController {

	// MARK: - Public properties

	var presenter: AuthPresenterProtocol?

	// MARK: - Private properties

	private var bottomConstraint: NSLayoutConstraint!
	private let contentView = UIView()
	private let container = UIView()
	private let imageView = UIImageView(image: .authImage)
	private let bottomSheet = UIView()
	private let titleLabel = UILabel()
	private let subtitle = UILabel()
	private let orView = OrView()
	private let login = CommonTextField()
	private let password = CommonTextField(isPassword: true)
	private let enter = CommonButton(.primary)
	private let registration = CommonButton(.secondary)
	private let forgotPass = CommonButton(.transparent)

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
		subscribeToKeyboardNotifications()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		unsubscribeFromKeyboardNotifications()
	}

	override func handleKeyboardDidShown(_ keyboardBounds: CGRect) {
		let enterButtonBottomOffset = bottomSheet.frame.height - enter.frame.origin.y - enter.frame.height
		let keyBoardOffset = keyboardBounds.height - view.safeAreaInsets.bottom
		let offset = enterButtonBottomOffset - keyBoardOffset - enter.frame.height - 40
		bottomConstraint.constant = offset

		UIView.animate(withDuration: 0.15, animations: { [weak self] in
			self?.view.layoutIfNeeded()
		})
	}

	override func handleKeyboardDidHidden(_ keyboardBounds: CGRect) {
		bottomConstraint.constant = 0
		UIView.animate(withDuration: 0.15, animations: { [weak self] in
			self?.view.layoutIfNeeded()
		})
	}
}

extension AuthViewController: AuthViewControllerProtocol {
	func present(for state: AuthState) {
		switch state {
		case .loading:
			enter.isLoading = true
		case .authorized:
			login.validationEnded(with: .correct)
			password.validationEnded(with: .correct)
			enter.isLoading = false
		case .base:
			login.validationEnded(with: .base)
			password.validationEnded(with: .base)
			enter.isLoading = false
			configureView()
		case .error(let type, let message):
			enter.isLoading = false
			processError(with: type, message: message)
		}
	}
}

private extension AuthViewController {
	func setupView() {
		addSubviews()
		configureView()
		configureContainer()
	}

	func addSubviews() {
		view.addSubview(imageView)
		view.addSubview(bottomSheet)
		bottomSheet.addSubview(container)

		let height = UIScreen.main.bounds.height - (UIScreen.main.bounds.width * 0.64 + view.safeAreaInsets.top - 20)
		bottomSheet.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.height.equalTo(height)
		}
		bottomConstraint = bottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		bottomConstraint.isActive = true

		imageView.snp.makeConstraints { make in
			make.centerX.width.equalToSuperview()
			make.height.equalTo(imageView.snp.width).multipliedBy(0.64)
			make.top.equalTo(view.safeAreaLayoutGuide)
		}

		container.snp.makeConstraints { make in
			make.leading.trailing.bottom.top.equalToSuperview().inset(24)
		}
	}

	func configureContainer() {
		container.addSubview(forgotPass)
		[titleLabel, subtitle, login, password, enter, orView, registration].forEach {
			container.addSubview($0)
			$0.snp.makeConstraints { make in make.leading.trailing.equalToSuperview() }
		}
		titleLabel.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(16)
			make.height.equalTo(30)
		}
		subtitle.snp.makeConstraints { make in
			make.top.equalTo(titleLabel.snp.bottom).offset(8)
			make.height.equalTo(18)
		}
		login.snp.makeConstraints { make in
			make.top.equalTo(subtitle.snp.bottom).offset(32)
			make.height.equalTo(50)
		}
		password.snp.makeConstraints { make in
			make.top.equalTo(login.snp.bottom).offset(16)
			make.height.equalTo(50)
		}
		forgotPass.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.top.equalTo(password.snp.bottom).offset(16)
			make.height.equalTo(16)
		}
		enter.snp.makeConstraints { make in
			make.top.equalTo(forgotPass.snp.bottom).offset(32)
			make.height.equalTo(40)
		}
		orView.snp.makeConstraints { make in
			make.top.equalTo(enter.snp.bottom).offset(16)
			make.height.equalTo(18)
		}
		registration.snp.makeConstraints { make in
			make.top.equalTo(orView.snp.bottom).offset(16)
			make.height.equalTo(40)
		}
	}

	func configureView() {
		view.backgroundColor = .baseBackground

		bottomSheet.backgroundColor = .white
		bottomSheet.clipsToBounds = true
		bottomSheet.layer.cornerRadius = 8
		bottomSheet.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]

		enter.setTitle("Войти", for: .normal)
		enter.addTarget(self, action: #selector(enterAction), for: .touchUpInside)
		registration.setTitle("Регистрация", for: .normal)
		registration.addTarget(self, action: #selector(registrationAction), for: .touchUpInside)
		forgotPass.setTitle("Забыли пароль?", for: .normal)
		login.placeholder = "Логин"
		password.placeholder = "Пароль"
		login.delegate = self
		password.delegate = self

		subtitle.text = "Общайтесь без ограничений"
		subtitle.font = .standart(style: .regular, of: 14)
		titleLabel.text = "Авторизируйтесь"
		titleLabel.font = .standart(style: .bold, of: 24)
	}

	func processError(with type: AuthError, message: String) {
		switch type {
		case .internet:
			break
		case .incorrectPassword:
			password.validationEnded(with: .error(message: message))
		case .incorrectLogin:
			login.validationEnded(with: .error(message: message))
		}
	}

	@objc
	func enterAction() {
		window.endEditing(true)
		guard let credentials = validateTexts() else { return }
		enter.isLoading = true
		presenter?.load(with: credentials)
	}

	@objc func registrationAction() {
		presenter?.showRegistration()
	}

	func validateTexts() -> AuthCredensial? {
		let passwordText = password.text
		let loginText = login.text
		guard let loginText = loginText,
			let passwordText = passwordText else {
			if passwordText == nil { password.validationEnded(with: .error(message: "Введите пароль")) }
			if loginText == nil { login.validationEnded(with: .error(message: "Введите логин")) }
			return nil
		}
		return AuthCredensial(login: loginText, password: passwordText)
	}
}

extension AuthViewController: CommonTextFieldDelegate {}
