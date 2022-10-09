//
//  RegistrationService.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

final class RegistrationService {

	func check(text: String, type: RegistrationCredType, completion: @escaping ((Bool, String?) -> Void)) {
		switch type {
		case .name:
			completion(true, nil)
		case .password:
			completion(true, nil)
		case .phone:
			completion(true, nil)
		case .email:
			completion(true, nil)
		}
	}
}
