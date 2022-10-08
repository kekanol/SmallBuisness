//
//  SearchScreenAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import Foundation

final class SearchScreenAssembly {
	static func build() -> SearchScreenViewController {
		let interactor = SearchScreenInteractor()
		let presenter = SearchScreenPresenter()
		let viewController = SearchScreenViewController()
		let service = SearchScreenServiceMock()

		let dataSource = SearchScreenTapeDataSource(collectionView: viewController.collection)

		presenter.dataSource = dataSource
		presenter.viewController = viewController

		interactor.presenter = presenter
		interactor.service = service

		viewController.interactor = interactor

		return viewController
	}
}
