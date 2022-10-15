//
//  LoadingViewController.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let image = UIImageView(image: UIImage.heartFilled.withTintColor(.primary))
		image.frame.size = CGSize(width: 216, height: 216)
		image.center = view.center
		view.addSubview(image)
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			self?.setLoadConfig()
		}
    }

	func setLoadConfig() {
		let rootNC = CommonNavigationController()
		UIApplication.shared.window?.rootViewController = rootNC
		UIApplication.shared.window?.makeKeyAndVisible()
		Router.shared.currentNC = rootNC
		if AccountProvider.shared.currentState == .none {
			Router.shared.openAuthorization()
		} else {
			Router.shared.mainScreenRouter.showMainScreen()
		}
	}
}

