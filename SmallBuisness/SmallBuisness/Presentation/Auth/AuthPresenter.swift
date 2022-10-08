//
//  AuthInteractor.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
	func load(with credensial: AuthCredensial)
	func showRegistration()
}

final class AuthPresenter {

	// MARK: - Private properties

	private weak var viewController: AuthViewControllerProtocol?
	private let service: AuthServiceProtocol

	init(viewController: AuthViewControllerProtocol, service: AuthServiceProtocol) {
		self.viewController = viewController
		self.service = service
	}
}

extension AuthPresenter: AuthPresenterProtocol {
	func load(with credensial: AuthCredensial) {
		viewController?.present(for: .loading)
		service.load(with: credensial) { [weak self] authError in
			guard let self = self else { return }
			guard let error = authError else {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					self.showMain()
				}
				AccountProvider.shared.setState(.fizik)
				self.viewController?.present(for: .authorized)
				return
			}
			let message: String
			switch error {
			case .internet: message = "Нет доступа к интернету"
			case .incorrectPassword: message = "Неверный пароль"
			case .incorrectLogin: message = "Аккаунт с таким именем не найден"
			}

			self.viewController?.present(for: .error(type: error, message: message))
		}

	}

	func showRegistration() {
		Router.shared.openRegistration()
	}
}

private extension AuthPresenter {
	func showMain() {
		Router.shared.mainScreenRouter.showMainScreen()
	}
}
