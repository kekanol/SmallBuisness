//
//  PostCellViewInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellViewInteractor {

	var service: PostCellViewServiceProtocol
	var dataBaseService: PostCellViewDataBaseServiceProtocol

	init(service: PostCellViewServiceProtocol,
		 dataBaseService: PostCellViewDataBaseServiceProtocol) {
		self.service = service
		self.dataBaseService = dataBaseService
	}

	enum ImageType {
		case post
		case account
		case coment
	}
}

extension PostCellViewInteractor {
	func loadImage(with url: URL, imageType: ImageType, completion: @escaping ((UIImage) -> Void)) {

	}
}
