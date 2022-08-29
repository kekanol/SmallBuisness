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

		viewController.interactor = interactor
		interactor.presenter = presenter
		presenter.viewController = viewController

		return viewController
	}
}
