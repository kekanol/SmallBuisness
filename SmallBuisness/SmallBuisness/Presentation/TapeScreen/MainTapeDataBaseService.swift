//
//  MainTapeDataBaseService.swift
//  SmallBuisness
//
//  Created by Константин on 06.08.2022.
//

import Foundation

protocol MainTapeDataBaseServiceProtocol {
	func loadPosts(_ completion: @escaping (([Post]) -> Void))
}

final class MainTapeDataBaseService: MainTapeDataBaseServiceProtocol {
	func loadPosts(_ completion: @escaping (([Post]) -> Void)) {

	}
}

final class MainTapeDataBaseServiceMock: MainTapeDataBaseServiceProtocol {
	func loadPosts(_ completion: @escaping (([Post]) -> Void)) {
		let result = createPosts()
		completion(result)
	}

	private func createPosts() -> [Post] {
		var posts: [Post] = []

		for i in 0...5 {
			let acc = Account(imageUrl: URL(string: "https://avatars.mds.yandex.net/i?id=b7a249f48c97a8524927344c948a23dd-5233058-images-thumbs&n=13")!,
							  name: "beka",
							  id: "\(i)")
			let post = Post(id: "\(i)",
							account: acc,
							imageUrl: URL(string: "https://zoo-ekb.ru/uploads/product_filters_value/1226/photo.jpg")!,
							isProduct: false,
							description: "post from database image \(i)",
							likeCount: 0,
							isLiked: false,
							isFavourite: false,
							comments: [])
			posts.append(post)
		}

		return posts
	}
}
