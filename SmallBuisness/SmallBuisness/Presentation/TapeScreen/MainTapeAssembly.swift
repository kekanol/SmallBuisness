//
//  MainTapeAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

final class MainTapeAssembly {
	static func build() -> MainTapeViewControllerProtocol {
		let viewController = MainTapeViewController()
		let interactor = MainTapeInteractor()
		let presenter = MainTapePresenter()
		let dataSource = MainTapeDataSource(collectionView: viewController.collection)
		let service = MainTapeServiceMock()
		let dbServise = MainTapeDataBaseServiceMock()

		viewController.interactor = interactor

		interactor.service = service
		interactor.dbService = dbServise
		interactor.presenter = presenter

		presenter.dataSource = dataSource
		presenter.viewController = viewController

		return viewController
	}
}
