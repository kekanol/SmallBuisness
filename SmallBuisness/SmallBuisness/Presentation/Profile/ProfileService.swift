//
//  ProfileService.swift
//  SmallBuisness
//
//  Created by Константин on 09.11.2022.
//

import Foundation

final class ProfileService {
	func loadPosts(with ids: [String], completion: @escaping ([Post]) -> Void) {
		let posts = createMockPosts()
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			completion(posts)
		}
	}

	private func createMockPosts() -> [Post] {
		var posts = [Post]()
		for i in 0...20 {
			let acc = CurrentUser.shared.asAccount()
			let post = Post(id: "\(i)",
							account: acc,
							imageUrl: URL(string: "https://zoo-ekb.ru/uploads/product_filters_value/1226/photo.jpg")!,
							isProduct: false,
							description: "Очень интересный текст про то, что изображено на посте Очень интересный текст про то, что изображено на посте \(i)",
							likeCount: 0,
							isLiked: false,
							isFavourite: false,
							date: Date(),
							comments: createComents())
			posts.append(post)
		}
		return posts
	}

	private func createComents() -> [Comment] {
		var coments = [Comment]()
		let randomCount = Range(0...10).randomElement()!
		for index in 0...randomCount {
			let coment = Comment(accountImageUrl: URL(string: "https://avatars.mds.yandex.net/i?id=b7a249f48c97a8524927344c948a23dd-5233058-images-thumbs&n=13")!,
								 accountName: "user \(index)",
								 text: "Очень интересный текст про то, что изображено на посте номер \(index). Пиздатенько",
								 isLiked: .random(),
								 likesCount: randomCount,
								 date: Date())
			coments.append(coment)
		}
		return coments
	}
}
