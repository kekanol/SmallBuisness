//
//  AddPostInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 29.08.2022.
//

import Foundation

final class AddPostInteractor {
	var presenter: AddPostPresenter!
	var dataSource: AddPostDataSource!
	var imageService: AddPostPhotoService!
	
}

extension AddPostInteractor {
	func processViewAppeared() {
		imageService.loadPhotos { [weak self] images in
			guard let self = self else { return }
			guard !images.isEmpty else {
				self.presenter.presentError()
				return
			}
			self.dataSource.setItems(with: images)
		}
	}
}
