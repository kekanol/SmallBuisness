//
//  AddPostInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 29.08.2022.
//

import UIKit

final class AddPostInteractor {
	var presenter: AddPostPresenter!
	var dataSource: AddPostDataSource!
	var imageService: AddPostPhotoService!

	private var multiplyerForImageFetch = 1
}

extension AddPostInteractor {
	func processViewAppeared() {
		imageService.loadPhotos(multiplyer: multiplyerForImageFetch) { [weak self] images in
			guard let self = self else { return }
			guard !images.isEmpty else {
				self.presenter.presentError()
				return
			}
			self.dataSource.setItems(with: images)
		}
	}

	func processImageSelected(_ image: UIImage) {

	}

	func loadMore() {
		multiplyerForImageFetch += 1
		imageService.loadPhotos(multiplyer: multiplyerForImageFetch) { [weak self] images in
			guard let self = self else { return }
			self.dataSource.setItems(with: images)
		}
	}
}
