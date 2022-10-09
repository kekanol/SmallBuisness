//
//  RegistrationPresenter.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import Foundation
import UIKit

final class RegistrationPresenter {

	private var model = RegistrationModel()
	private let service = RegistrationService()
	var keyboardHeight: CGFloat = 0

	func askIfCanContinue(with type: RegistrationCredType, text: String, completion: @escaping ((Bool) -> Void)) {
		switch type {
		case .name:
			model.name = text
		case .password:
			model.password = text
		case .phone:
			model.phone = text
		case .email:
			model.email = text
		}
		guard model.isReadyToContinue(for: type) else {
			completion(false)
			return
		}
		service.check(text: text, type: type) { [weak self] isOK, message in
			guard let self = self else { return }
			completion(isOK)
			guard isOK, message == nil else {
				print(self.keyboardHeight)
				Router.shared.showSnackBar(with: message, isError: true, keyboardHeight: self.keyboardHeight)
				return
			}
			self.openNext(from: type)
		}
	}

	private func openNext(from type: RegistrationCredType) {
		let vc: UIViewController
		switch type {
		case .name:
			vc = RegistrationPasswordViewController(presenter: self)
		case .password:
			vc = RegistrationEmailViewController(presenter: self)
		case .phone:
			vc = LoadingScreen()
		case .email:
			vc = RegistrationPhoneViewController(presenter: self)
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
			Router.shared.currentNC?.pushViewController(vc, animated: true)
			if type == .phone {
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					AccountProvider.shared.setState(.fizik)
					Router.shared.mainScreenRouter.showMainScreen()
				}
			}
		}
	}
}
