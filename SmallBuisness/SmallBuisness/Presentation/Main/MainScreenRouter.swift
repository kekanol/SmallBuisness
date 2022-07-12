//
//  MainScreenRouter.swift
//  startap777
//
//  Created by Константин on 10.07.2022.
//

import Foundation

final class MainScreenRouter {
	func showMainScreen() {
		let vc = MainScreenViewController()
		let nc = Router.shared.currentNC
		nc?.setViewControllers([vc], animated: true)
	}
}
