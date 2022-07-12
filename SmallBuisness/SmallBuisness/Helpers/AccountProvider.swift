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
	private(set) var currentState: AccountState

	private init() {
		currentState = .none
	}

	enum AccountState {
		case none
		case urik
		case fizik
	}

	func setState(_ state: AccountState) {
		currentState = state
	}
}
