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
		self.tabBar.tintColor = .primary
		setupControllers()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		PhotoLibraryAccessor.shared.requestAccess { _ in }
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
		let vc = MainTapeAssembly.build()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: "",
			image: UIImage.homeOutline.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
	
	func getSearchScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = SearchScreenAssembly.build()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.searchOutline.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}

	func getNewPostScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = AddPostAssembly().build()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.plusCircleOutline.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
//	
//	func getCartScreen() -> UIViewController {
//		let nc = CommonNavigationController()
//		let vc = UIViewController()
//		nc.viewControllers = [vc]
//		nc.tabBarItem = UITabBarItem(
//			title: nil,
//			image: UIImage.cart.withRenderingMode(.alwaysTemplate),
//			selectedImage: nil)
//		nc.tabBarItem.imageInsets = UIEdgeInsets()
//		return nc
//	}
	
	func getProfileScreen() -> UIViewController {
		let nc = CommonNavigationController()
		let vc = ProfileAssembly().build()
		nc.viewControllers = [vc]
		nc.tabBarItem = UITabBarItem(
			title: nil,
			image: UIImage.userOutline.withRenderingMode(.alwaysTemplate),
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
			image: UIImage.pencilSquare.withRenderingMode(.alwaysTemplate),
			selectedImage: nil)
		nc.tabBarItem.imageInsets = UIEdgeInsets()
		return nc
	}
}
