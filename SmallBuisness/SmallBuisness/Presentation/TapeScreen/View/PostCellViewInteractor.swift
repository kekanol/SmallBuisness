//
//  PostCellViewInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellViewInteractor {

	private var dataBaseService: PostCellViewDataBaseServiceProtocol

	init(dataBaseService: PostCellViewDataBaseServiceProtocol) {
		self.dataBaseService = dataBaseService
	}
}

enum ImageType: String {
	case post
	case avatar
}

extension PostCellViewInteractor {
	func loadImage(with post: Post, imageType: ImageType, completion: @escaping ((UIImage?) -> Void)) {
		let loadUrl = imageType == .post ? post.imageUrl: post.account.imageUrl
		let id = imageType == .post ? post.id : post.account.id
		let dbUrl = imageType.rawValue + id + ".jpg"
		if let image = dataBaseService.getImage(for: dbUrl) {
			completion(image)
		}

		ImageLoader.shared.loadImage(with: loadUrl) { [weak self] data in
			guard let self = self,
				  let data = data,
				  let image = UIImage(data: data) else {
				completion(nil)
				return
			}
			completion(image)
			self.dataBaseService.saveImage(image: image, for: id, imageType: imageType)
		}
	}
}
