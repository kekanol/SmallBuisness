//
//  ProfileAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 15.11.2022.
//

final class ProfileAssembly {
	func build() -> ProfileViewController {
		let viewController = ProfileViewController()
		let service = ProfileService()
		let presenter = ProfilePresenter()
		let dataSource = ProfileDataSource(collectionView: viewController.collection)
		let interactor = ProfileInteractor(service: service, presenter: presenter)
		presenter.viewController = viewController
		presenter.dataSource = dataSource
		viewController.interactor = interactor
		viewController.collection.dataSource = dataSource
		viewController.collection.delegate = dataSource

		return viewController
	}
}
