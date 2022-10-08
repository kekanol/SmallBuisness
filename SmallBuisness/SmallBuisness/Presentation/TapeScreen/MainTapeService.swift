//
//  MainTapeService.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

protocol MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void))
}

final class MainTapeService {

	enum TapeError: Error {
		case noError
	}
}

extension MainTapeService: MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void)) {

	}
}

final class MainTapeServiceMock: MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void)) {
		let result = createPosts()
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			completion(.success(result))
		}
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
							description: "hui hui image \(i)",
							likeCount: 0,
							isLiked: false,
							isFavourite: false,
							comments: [])
			posts.append(post)
		}

		return posts
	}
}
