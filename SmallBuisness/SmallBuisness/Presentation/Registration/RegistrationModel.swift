//
//  RegistrationModel.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

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
			return password != ""
		case .phone:
			return phone != ""
		case .email:
			return email != ""
		}
	}
}

enum RegistrationCredType {
	case name
	case password
	case phone
	case email
}
