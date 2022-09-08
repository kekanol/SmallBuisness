//
//  AddPostDataSource.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import UIKit

final class AddPostDataSource: DataSource {

	private var images = [UIImage?]() {
		didSet {
			update(animated: true)
		}
	}
	private var header: BigPhotoHeader?
	private var selectedImage: UIImage?
	private var canLoadMore: Bool = true

	var imageDidSelect: ((UIImage) -> Void)?
	var askLoadMore: (() -> Void)?

	func setItems(with images: [UIImage?]) {
		if selectedImage == nil {
			selectedImage = images.first ?? nil
		}
		let ostatok = images.count % 4
		let newImages = images + Array(repeating: nil, count: ostatok)
		canLoadMore = newImages.count != self.images.count
		self.images = newImages
	}

	override func registerCells() {
		collectionView?.register(class: PhotoCell.self)
		collectionView?.register(class: BigPhotoHeader.self, kind: "UICollectionElementKindSectionHeader")
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = images[indexPath.row]
		return ElementConfigurator(reuseIdentifier: PhotoCell.reuseIdentifier, configurationBlock: { (cell) in
			guard let cell = cell as? PhotoCell else { return }
			if let image = model {
				cell.configure(image: image)
			}
		})
	}

	override func numberOfElementsInSection(_ section: Int) -> Int {
		return images.count
	}

	override func numberOfSections() -> Int {
		return 1
	}

	override func rowAction(_ indexPath: IndexPath) {
		if let image = images[indexPath.row] {
			selectedImage = image
			imageDidSelect?(image)
			header?.configure(image)
		}
	}

	override func collectionView(_ collectionView: UICollectionView,
								 viewForSupplementaryElementOfKind kind: String,
								 at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader",
																	 withReuseIdentifier: BigPhotoHeader.reuseIdentifier,
																	 for: indexPath) as! BigPhotoHeader
		header.configure(selectedImage)
		self.header = header
		return header
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						referenceSizeForHeaderInSection section: Int) -> CGSize {
		let width = collectionView.bounds.width
		return CGSize(width: width, height: width)
	}

	override func sizeForItem(_ indexPath: IndexPath) -> CGSize {
		let width = collectionView!.bounds.width / 4 - 1
		return CGSize(width: width, height: width)
	}

	override func collectionView(_ collectionView: UICollectionView,
								 layout collectionViewLayout: UICollectionViewLayout,
								 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}

	override func collectionView(_ collectionView: UICollectionView,
								 layout collectionViewLayout: UICollectionViewLayout,
								 minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}

	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offset = scrollView.contentOffset.y
		let size = scrollView.contentSize.height
		let contentBottomInsetY = size - offset
		if contentBottomInsetY < UIScreen.main.bounds.height / 5,
		   canLoadMore {
			askLoadMore?()
		}
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
