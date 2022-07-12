//
//  AuthAssembly.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

final class AuthAssembly {

	static func build() -> AuthViewControllerProtocol {
		let service = AuthService()
		let viewController = AuthViewController()
		let presenter = AuthPresenter(viewController: viewController, service: service)
		viewController.presenter = presenter

		return viewController
	}
}
