//
//  ProfileSettingsPresenter.swift
//  SmallBuisness
//
//  Created by Константин on 30.11.2022.
//

import Foundation

final class ProfileSettingsPresenter {

	weak var viewController: ProfileSettingsViewController?
	private let factory: ProfileSettingsFactory

	init(factory: ProfileSettingsFactory) {
		self.factory = factory
	}

	func loadItems() {
		let views = factory.generateItems()
		viewController?.setViews(views)
	}
}
