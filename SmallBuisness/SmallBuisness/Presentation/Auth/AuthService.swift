//
//  AuthService.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import Foundation

protocol AuthServiceProtocol: AnyObject {
	func load(with credensials: AuthCredensial, completion: @escaping (() -> Void))
}

final class AuthService {
	
}

extension AuthService: AuthServiceProtocol {
	func load(with credensials: AuthCredensial, completion: @escaping (() -> Void)) {
		completion()
	}
}
