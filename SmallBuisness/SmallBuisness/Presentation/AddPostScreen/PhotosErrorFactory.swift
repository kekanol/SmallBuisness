//
//  PhotosErrorFactory.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import Foundation

final class PhotosErrorFactory {
	func getError() -> PhotosError {
		return PhotosError(title: "No images")
	}
}

struct PhotosError {
	let title: String
	let subtitle: String?
	let okButtonAction: (() -> Void)?
	let cancelButtonAction: (() -> Void)?

	init(title: String = "",
		 subtitle: String? = nil,
		 okButtonAction: (() -> Void)? = nil,
		 cancelButtonAction: (() -> Void)? = nil) {
		self.title = title
		self.subtitle = subtitle
		self.okButtonAction = okButtonAction
		self.cancelButtonAction = cancelButtonAction
	}
}
