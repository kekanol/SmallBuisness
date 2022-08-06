//
//  MainTapeDataSource.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

protocol MainTapeDataSourceProtocol: AnyObject {
	func setItems(_ items: [PostCellItem], animated: Bool)
}

final class MainTapeDataSource: DataSource {
	private var items: [PostCellItem] = []

	func refresh() {
		self.collectionView?.reloadData()
	}

	override func registerCells() {
		self.collectionView?.register(class: PostCell.self)
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = items[indexPath.row]
		return ElementConfigurator(reuseIdentifier: PostCell.identifier, configurationBlock: { (cell) in
			guard let cell = cell as? PostCell else { return }
			cell.configure(with: model)
		})
	}

	override func numberOfElementsInSection(_ section: Int) -> Int {
		return items.count
	}

	override func numberOfSections() -> Int {
		return 1
	}

	override func sizeForItem(_ indexPath: IndexPath) -> CGSize {
		let width = collectionView!.bounds.width
		let size = CGSize(width: width, height: width)
		return size
	}

	override func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

extension MainTapeDataSource: MainTapeDataSourceProtocol {
	func setItems(_ items: [PostCellItem], animated: Bool = true) {
		guard let collectionView = collectionView else { return }

		guard animated else {
			self.items = items
			collectionView.reloadData()
			return
		}

		self.items = items

		collectionView.performBatchUpdates({
			collectionView.reloadSections(IndexSet(integer: 0))
		})
	}
}
