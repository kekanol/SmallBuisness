//
//  AuthService.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
	func load(with credensials: AuthCredensial, completion: @escaping ((AuthError?) -> Void))
}

enum AuthError: Error {
	case internet
	case incorrectPassword
	case incorrectLogin
}

final class AuthService {
	private let basePassword = "1234"
	private let baseLogin = "qwerty"
}

extension AuthService: AuthServiceProtocol {
	func load(with credensials: AuthCredensial, completion: @escaping ((AuthError?) -> Void)) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			let correctPass = credensials.password == self.basePassword
			let correctLogin = credensials.login == self.baseLogin
			let success = correctPass && correctLogin
			if success {
				completion(nil)
			} else {
				if !correctLogin { completion(AuthError.incorrectLogin); return }
				if !correctPass { completion(AuthError.incorrectPassword); return }
				completion(AuthError.internet)
			}
		}
	}
}
