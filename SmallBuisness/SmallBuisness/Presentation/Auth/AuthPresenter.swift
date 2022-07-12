//
//  AuthInteractor.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
	func load(with credensial: AuthCredensial)
	func showMain()
}

final class AuthPresenter {

	// MARK: - Private properties

	private weak var viewController: AuthViewControllerProtocol?
	private let service: AuthServiceProtocol

	private var state: AuthState = .base

	init(viewController: AuthViewControllerProtocol, service: AuthServiceProtocol) {
		self.viewController = viewController
		self.service = service
	}
}

extension AuthPresenter: AuthPresenterProtocol {
	func load(with credensial: AuthCredensial) {
		AccountProvider.shared.setState(.fizik)
		viewController?.present(for: .authorized)
	}

	func showMain() {
		Router.shared.mainScreenRouter.showMainScreen()
	}
}

private extension AuthPresenter {
	
}
