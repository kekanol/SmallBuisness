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

final class AuthViewController: UIViewController {

	// MARK: - Public properties

	var presenter: AuthPresenterProtocol?

	// MARK: - Private properties

	private let scrollView = UIScrollView()
	private let scrollCanvas = UIView()

	private let imageView = UIImageView()
	private let titleLabel =  UILabel()
	private let loginTextField = BaseTextField()
	private let passwordTextField = BaseTextField()
	private let enterButton = BaseButton()
	private let loadingView = BaseLoadingVeiw()

	private let texts = Strings()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		configureView()
	}
}

extension AuthViewController: AuthViewControllerProtocol {
	func present(for state: AuthState) {
		switch state {
		case .loading:
			loadingView.show()
		case .authorized:
			processAuthrized()
		case .base:
			configureView()
		case .error:
			loadingView.hide()
		}
	}
}

private extension AuthViewController {
	func setupView() {
		[scrollView,
		 scrollCanvas,
		 imageView,
		 titleLabel,
		 loginTextField,
		 passwordTextField,
		 enterButton].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
		}

		view.addSubview(scrollView)
		scrollView.addSubview(scrollCanvas)

		[imageView, titleLabel, loginTextField, passwordTextField, enterButton].forEach {
			scrollCanvas.addSubview($0)
		}

		setupConstraints()
	}

	func setupConstraints() {
		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.topAnchor.constraint(equalTo: view.topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			scrollCanvas.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
			scrollCanvas.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
			scrollCanvas.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
			scrollCanvas.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
			scrollCanvas.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

			imageView.centerXAnchor.constraint(equalTo: scrollCanvas.centerXAnchor),
			imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 81),
			imageView.widthAnchor.constraint(equalToConstant: 120),
			imageView.heightAnchor.constraint(equalToConstant: 120),

			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.smallOffset),
			titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			titleLabel.heightAnchor.constraint(equalToConstant: UIConstants.middleOffset),

			loginTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.bigOffset),
			loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loginTextField.heightAnchor.constraint(equalToConstant: 40),

			passwordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.middleOffset),
			passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			passwordTextField.heightAnchor.constraint(equalToConstant: 40),

			enterButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.bigOffset),
			enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			enterButton.heightAnchor.constraint(equalToConstant: 60)

		])
	}

	func configureView() {
		loginTextField.placeholder = texts.login
		passwordTextField.placeholder = texts.password
		enterButton.setTitle(texts.enter, for: .normal)
	}

	func processAuthrized() {
		SuccessFailView.presentSuccess(on: view) { [weak self] in
			guard let self = self else { return }
			self.presenter?.showMain()
		}
	}

	func processError() {
		SuccessFailView.presentFailure(on: view) { [weak self] in
			guard let self = self else { return }
			
		}
	}
}
