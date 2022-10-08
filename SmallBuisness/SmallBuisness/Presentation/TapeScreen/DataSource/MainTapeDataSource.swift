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
		self.tableView?.register(PostCell.self, forCellReuseIdentifier: PostCell.reuseIdentifier)
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = items[indexPath.row]
		return ElementConfigurator(reuseIdentifier: PostCell.reuseIdentifier, configurationBlock: { (cell) in
			guard let cell = cell as? PostCell else { return }
			cell.configure(with: model, indexPath: indexPath)
//			cell.sizeDidChange = { [weak self] indexPath in self?.collectionView?.reloadItems(at: [indexPath])}
		})
	}

	override func numberOfSections() -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	override func heightForRow(_ indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension MainTapeDataSource: MainTapeDataSourceProtocol {
	func setItems(_ items: [PostCellItem], animated: Bool = true) {
		guard let tableView = tableView else { return }

		guard animated else {
			self.items = items
			tableView.reloadData()
			return
		}

		self.items = items

		tableView.performBatchUpdates({
			tableView.reloadSections(IndexSet(integer: 0), with: .fade)
		})
	}
}
