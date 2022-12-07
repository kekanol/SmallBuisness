//
//  ProfileSettingsPresenter.swift
//  SmallBuisness
//
//  Created by Константин on 30.11.2022.
//

import Foundation

final class ProfileSettingsPresenter {

	weak var viewController: ProfileSettingsViewController?
	var dataSource: ProfileSettingsDataSource?
	private let factory: ProfileSettingsFactory

	init(factory: ProfileSettingsFactory) {
		self.factory = factory
	}

}
