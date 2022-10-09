//
//  ProfileViewController.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let button = CommonButton(.primary)
		button.frame = CGRect(x: 24, y: 400, width: UIConstants.screenWidth - 48, height: 48)
		button.setTitle("Выйти из аккаунта", for: .normal)
		view.addSubview(button)
		button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
	}

	@objc
	private func buttonAction() {
		AccountProvider.shared.setState(.none)
		Router.shared.openAuthorization()
	}
}
