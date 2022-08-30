//
//  AddPostAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 29.08.2022.
//

import Foundation

final class AddPostAssembly {
	func build() -> AddPostViewController {
		let viewController = AddPostViewController()
		let interactor = AddPostInteractor()
		let presenter = AddPostPresenter()
		let dataSource = AddPostDataSource(collectionView: viewController.collection)
		let service = AddPostPhotoService()
		let errorFactory = PhotosErrorFactory()

		viewController.interactor = interactor
		interactor.presenter = presenter
		interactor.imageService = service
		interactor.dataSource = dataSource
		presenter.viewController = viewController
		presenter.errorFactory = errorFactory

		return viewController
	}
}
