//
//  AccountProvider.swift
//  startap777
//
//  Created by Константин on 09.07.2022.
//

import Foundation

typealias AccountState = AccountProvider.AccountState

final class AccountProvider {

	static let shared = AccountProvider()
	private static let key = "userAuthorizationStatus"
	private(set) var currentState: AccountState {
		didSet {
			if currentState == .none { CurrentUser.shared.clear() }
		}
	}

	private init() {
		let value = UserDefaults.standard.string(forKey: Self.key)
		currentState = AccountState(rawValue: value)
	}

	enum AccountState: String {
		case none
		case urik
		case fizik

		init(rawValue: String?) {
			if rawValue == AccountState.urik.rawValue {
				self = .urik
			} else if rawValue == AccountState.fizik.rawValue {
				self = .fizik
			} else { self = .none }
		}
	}

	func setState(_ state: AccountState) {
		currentState = state
		UserDefaults.standard.set(currentState.rawValue, forKey: Self.key)
	}
}
