//
//  AuthCredensial.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

struct AuthCredensial: Codable {
	var login: String
	var password: String
}

enum AuthState {
	case loading
	case authorized
	case base
	case error
}
