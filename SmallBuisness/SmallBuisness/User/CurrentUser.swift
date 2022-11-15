//
//  CurrentUser.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class CurrentUser {

	private(set) var id: String = ""
	private(set) var name: String = ""
	private(set) var email: String = ""
	private(set) var phone: String = ""
	private(set) var imageURL: String?
	private(set) var nickName: String = ""
	private(set) var posts: [String] = []
	private(set) var subs: [String] = []
	private(set) var suberbs: [String] = []
	private(set) var description: String?

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
		id = user.id
		imageURL = user.imageURL
		nickName = user.nickName
		posts = user.posts
		subs = user.subs
		suberbs = user.suberbs
		description = user.description
	}

	func asAccount() -> Account {
		return Account(imageUrl: URL(string: "https://avatars.mds.yandex.net/i?id=b7a249f48c97a8524927344c948a23dd-5233058-images-thumbs&n=13"),
					   name: name,
					   nickName: nickName,
					   posts: posts,
					   subs: subs,
					   suberbs: suberbs,
					   description: description,
					   id: id)
	}

	func createBaseUser() {
		guard Constants.devBuild else { return }
		setUserData(id: "1488",
					name:"Konstantin Emelyanov",
					email: "1924gg@gmail.com",
					phone: "+7 (915) 046 02 42",
					imageURL: "https://avatars.mds.yandex.net/i?id=b7a249f48c97a8524927344c948a23dd-5233058-images-thumbs&n=13",
					nickName: "kekanol",
					posts: [],
					subs: [],
					suberbs: [],
					description: "Vse sosut bibu")
	}

	func setUserData(id: String,
					 name: String,
					 email: String,
					 phone: String,
					 imageURL: String?,
					 nickName: String,
					 posts: [String],
					 subs: [String],
					 suberbs: [String],
					 description: String?) {
		let user = User(id: id,
						name: name,
						email: email,
						phone: phone,
						imageURL: imageURL,
						nickName: nickName,
						posts: posts,
						subs: subs,
						suberbs: suberbs,
						description: description)
		userdefaults.set(try? PropertyListEncoder().encode(user), forKey: UserdefaultsKeys.userData.rawValue)
	}

	func clear() {
		userdefaults.set(nil, forKey: UserdefaultsKeys.userData.rawValue)
	}

	private struct User: Codable {
		var id: String
		var name: String
		var email: String
		var phone: String
		var imageURL: String?
		var nickName: String
		var posts: [String]
		var subs: [String]
		var suberbs: [String]
		var description: String?
	}
}
