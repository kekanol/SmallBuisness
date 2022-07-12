//
//  MainScreenViewController.swift
//  startap777
//
//  Created by Константин on 09.07.2022.
//

import SnapKit

final class MainScreenViewController: UITabBarController {

	private var state = AccountProvider.shared.currentState

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .white
		self.tabBar.backgroundColor = .white
		setupControllers()
	}
}

private extension MainScreenViewController {
	func setupControllers() {
		switch state {
		case.fizik:
			self.viewControllers = [
				getTapeScreen(),
				getSearchScreen(),
				getNewPostScreen(),
				getCartScreen(),
				getProfileScreen()
			]
		case .urik:
			self.viewControllers = [
				getTapeScreen(),
				getSearchScreen(),
				getNewPostScreen(),
				getOrdersScreen(),
				getProfileScreen()
			]
		case .none: break
		}
	}
	
	func getTapeScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = MainTapeViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: "",
			image: UIImage.paperPlaneTilt.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
	
	func getSearchScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = UIViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.magnifyingGlass.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}

	func getNewPostScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = UIViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.plusSquare.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
	
	func getCartScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = UIViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.cart.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
	
	func getProfileScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = UIViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.user.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}

	func getOrdersScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = UIViewController()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.bookOpen.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
}
