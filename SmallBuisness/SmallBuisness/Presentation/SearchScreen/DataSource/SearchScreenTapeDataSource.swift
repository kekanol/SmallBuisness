//
//  SearchScreenTapeDataSource.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import UIKit

protocol SearchScreenTapeDataSourceProtocol: AnyObject {
	func setItems(_ items: [SearchCellItem], animated: Bool)
}

final class SearchScreenTapeDataSource: DataSource {
	private var items: [SearchCellItem] = []

	func refresh() {
		self.collectionView?.reloadData()
	}

	override func registerCells() {
		self.collectionView?.register(class: SearchScreenCell.self)
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = items[indexPath.row]
		return ElementConfigurator(reuseIdentifier: SearchScreenCell.identifier, configurationBlock: { (cell) in
			guard let cell = cell as? SearchScreenCell else { return }
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
		return CGSize(width: width, height: width)
	}

	override func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0
	}
}

extension SearchScreenTapeDataSource: SearchScreenTapeDataSourceProtocol {
	func setItems(_ items: [SearchCellItem], animated: Bool = true) {
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
