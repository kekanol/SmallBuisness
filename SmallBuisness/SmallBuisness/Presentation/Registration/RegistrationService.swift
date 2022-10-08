//
//  RegistrationService.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

final class RegistrationService {

	func check(text: String, type: RegistrationCredType, completion: @escaping ((Bool) -> Void)) {
		switch type {
		case .name:
			completion(true)
		case .password:
			completion(true)
		case .phone:
			completion(true)
		case .email:
			completion(true)
		}
	}
}
