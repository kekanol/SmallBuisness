//
//  AddPostDataSource.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import UIKit

protocol AddPostDataSourceDelegate: AnyObject {
	func okButtonDidTap()
	func cancelBittonDidTap()
	func imageDidSelect(_ image: UIImage)
	func askLoadMore()
}

final class AddPostDataSource: DataSource {

	weak var delegate: AddPostDataSourceDelegate?
	private(set) var selectedImage: UIImage?
	private(set) var header: BigPhotoHeader?

	private var images = [UIImage?]() {
		didSet {
			update(animated: true)
		}
	}
	private var canLoadMore: Bool = true

	func setItems(with images: [UIImage?]) {
		if selectedImage == nil {
			selectedImage = images.first ?? nil
		}
		let ostatok = 4 - images.count % 4
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
			delegate?.imageDidSelect(image)
			header?.configure(image)
		}
	}

	override func collectionView(_ collectionView: UICollectionView,
								 viewForSupplementaryElementOfKind kind: String,
								 at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader",
																	 withReuseIdentifier: BigPhotoHeader.reuseIdentifier,
																	 for: indexPath) as! BigPhotoHeader
		header.okButtonTapped = { [weak self] in
			self?.delegate?.okButtonDidTap()
			self?.collectionView?.isScrollEnabled = false
		}
		header.cancelButtonTapped = { [weak self] in
			self?.delegate?.cancelBittonDidTap()
			self?.collectionView?.isScrollEnabled = true
		}
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
			delegate?.askLoadMore()
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
