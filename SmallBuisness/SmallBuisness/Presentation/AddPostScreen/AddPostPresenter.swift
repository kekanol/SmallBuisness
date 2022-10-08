//
//  AddPostPresenter.swift
//  SmallBuisness
//
//  Created by Константин on 29.08.2022.
//

import Foundation

final class AddPostPresenter {
	weak var viewController: AddPostViewController?
	var errorFactory: PhotosErrorFactory!

	func presentError() {
		let error = errorFactory.getError()
		viewController?.presentError(with: error)
	}
}
