//
//  RegistrationModel.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import Foundation

struct RegistrationModel {
	var name: String = ""
	var password: String = ""
	var phone: String = ""
	var email: String = ""

	func isReadyToContinue(for type: RegistrationCredType) -> Bool {
		switch type {
		case .name:
			return name != ""
		case .password:
			return checkPassword()
		case .phone:
			return checkPhone()
		case .email:
			return checkEmail()
		}
	}

	private func checkPhone() -> Bool {
		phone != "" && phone.clean().count == 11
	}

	private func checkEmail() -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}

	private func checkPassword() -> Bool {
		// минимум 8 символов, 1 заглавная буква, 1 цифра
		let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
		return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
	}
}

enum RegistrationCredType {
	case name
	case password
	case phone
	case email
}
