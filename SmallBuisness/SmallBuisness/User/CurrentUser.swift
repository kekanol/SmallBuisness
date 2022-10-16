//
//  CurrentUser.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class CurrentUser {

	private(set) var name: String = ""
	private(set) var email: String = ""
	private(set) var phone: String = ""
	private(set) var image: UIImage?

	static let shared = CurrentUser()
	private let userdefaults = UserDefaults.standard

	private init() {
		fetchData()
	}

	private func fetchData() {
		guard let data = userdefaults.value(forKey: UserdefaultsKeys.userData.rawValue) as? Data,
			  let user = try? PropertyListDecoder().decode(User.self, from: data) else {
			return
		}
		name = user.name
		email = user.email
		phone = user.phone
		if let imageData = user.imageData {
			image = UIImage(data: imageData)
		}
	}

	func createBaseUser() {
		guard Constants.devBuild else { return }
		setUserData(name: "kekanol", email: "1924gg@gmail.com", phone: "+7 (915) 046 02 42", imageData: nil)
	}

	func setUserData(name: String, email: String, phone: String, imageData: Data?) {
		let user = User(name: name, email: email, phone: phone, imageData: imageData)
		userdefaults.set(try? PropertyListEncoder().encode(user), forKey: UserdefaultsKeys.userData.rawValue)
	}

	func clear() {
		userdefaults.set(nil, forKey: UserdefaultsKeys.userData.rawValue)
	}

	private struct User: Codable {
		var name: String
		var email: String
		var phone: String
		var imageData: Data?
	}
}
