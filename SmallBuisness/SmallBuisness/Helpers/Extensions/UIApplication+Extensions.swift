//
//  UIApplication+Extensions.swift
//  SmallBuisness
//
//  Created by Константин on 12.07.2022.
//

import UIKit

extension UIApplication {

	var window: UIWindow? {
		let connectedScenes = UIApplication.shared.connectedScenes
					.filter({
						$0.activationState == .foregroundActive})
					.compactMap({$0 as? UIWindowScene})
		let window = connectedScenes.first?
					.windows
					.first { $0.isKeyWindow }
		return window
	}

}
