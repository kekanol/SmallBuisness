//
//  MainTapeDataSource.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

protocol MainTapeDataSourceProtocol: AnyObject {
	func setItems(_ items: [MainTapeItem])
}

final class MainTapeDataSource: CollectionDataSource {
	private var items: [MainTapeItem] = []

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = items[indexPath.row]
		if let cellItem = item as? PostCellItem {
			let cell = PostCell(frame: .zero, item: cellItem)
			return cell
		}
		return UICollectionViewCell()
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		items.count
	}
}

extension MainTapeDataSource: MainTapeDataSourceProtocol {
	func setItems(_ items: [MainTapeItem]) {
		self.items = items
		collection.reloadData()
	}
}
