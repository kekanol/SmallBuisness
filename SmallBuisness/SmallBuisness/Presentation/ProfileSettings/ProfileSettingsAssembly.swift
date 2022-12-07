//
//  ProfileSettingsAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 30.11.2022.
//

final class ProfileSettingsAssembly {
	func build() -> ProfileSettingsViewController {

		let factory = ProfileSettingsFactory()
		let presenter = ProfileSettingsPresenter(factory: factory)
		let interactor = ProfileSettingsInteractor(presenter: presenter)
		let viewController = ProfileSettingsViewController(interactor: interactor)

		let dataSource = ProfileSettingsDataSource(tableView: viewController.table)
		presenter.dataSource = dataSource
		presenter.viewController = viewController

		return viewController
	}
}
