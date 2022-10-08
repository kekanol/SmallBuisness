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
		let dataSource = MainTapeDataSource(tableView: viewController.tableView)
		let service = MainTapeServiceMock()

		viewController.interactor = interactor

		interactor.service = service
		interactor.presenter = presenter

		presenter.dataSource = dataSource
		presenter.viewController = viewController

		return viewController
	}
}
