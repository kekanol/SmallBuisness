//
//  PostCellViewInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellViewInteractor {
	func loadImage(with post: Post, imageType: ImageType, completion: @escaping ((UIImage?) -> Void)) {
		let loadUrl = imageType == .post ? post.imageUrl: post.account.imageUrl

		ImageLoader.shared.loadImage(with: loadUrl) { data in
			guard let data = data,
				  let image = UIImage(data: data) else {
				completion(nil)
				return
			}
			completion(image)
		}
	}
}

enum ImageType: String {
	case post
	case avatar
}
