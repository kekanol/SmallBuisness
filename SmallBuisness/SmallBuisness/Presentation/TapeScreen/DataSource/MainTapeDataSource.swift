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
		self.tableView?.reloadData()
	}

	override func registerCells() {
		collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = items[indexPath.row]
		return ElementConfigurator(reuseIdentifier: PostCell.reuseIdentifier, configurationBlock: { (cell) in
			guard let cell = cell as? PostCell else { return }
			cell.configure(with: model, indexPath: indexPath)
			cell.didTapComent = { _ in
				Router.shared.openComents(for: self.items[indexPath.row].post)
			}
//			cell.sizeDidChange = { [weak self] indexPath in self?.collectionView?.reloadItems(at: [indexPath])}
		})
	}

	override func numberOfSections() -> Int {
		return 1
	}

	override func numberOfElementsInSection(_ section: Int) -> Int {
		items.count
	}

	override func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
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
