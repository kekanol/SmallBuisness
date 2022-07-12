//
//  CommonNavigationController.swift
//  startap777
//
//  Created by Константин on 09.07.2022.
//

import UIKit

class CommonNavigationController: UINavigationController {
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.shadowImage = UIImage()
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.barTintColor = .clear
		navigationBar.tintColor = .white
		navigationItem.setHidesBackButton(true, animated: false)
		navigationItem.backButtonTitle = ""
		navigationItem.hidesBackButton = true
		interactivePopGestureRecognizer?.delegate = nil
		self.delegate = nil
	}
}
