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
		let image = UIImageView(image: UIImage.baseImage)
		view.addSubview(image)
		image.snp.makeConstraints { make in
			make.center.width.equalTo(view.safeAreaLayoutGuide)
			make.height.equalTo(image.snp.width)
		}
		let title = UILabel()
		title.text = "СИСЬКИ"
		title.font = .standart(style: .medium, of: 30)
		view.addSubview(title)
		title.snp.makeConstraints { make in
			make.top.equalTo(image.snp.bottom).offset(24)
			make.centerX.equalToSuperview()
		}
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

