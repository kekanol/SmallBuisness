//
//  AddPostDataSource.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import UIKit

final class AddPostDataSource: DataSource {

	private var images = [UIImage]() {
		didSet {
			update(animated: true)
		}
	}

	func setItems(with images: [UIImage]) {
		self.images = images
	}
}

private extension AddPostDataSource {
	func update(animated: Bool) {
		guard let collectionView = collectionView else { return }

		guard animated else {
			collectionView.reloadData()
			return
		}

		collectionView.performBatchUpdates({
			collectionView.reloadSections(IndexSet(integer: 0))
		})
	}
}
