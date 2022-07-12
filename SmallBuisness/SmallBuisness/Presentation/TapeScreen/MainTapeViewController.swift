//
//  MainTapeViewController.swift
//  SmallBuisness
//
//  Created by Константин on 12.07.2022.
//

import UIKit

protocol MainTapeViewControllerProtocol: UIViewController {

	func loadInitialConfiguration()

	func refresh()

	func setItems(_ items: [MainTapeItem])
}

final class MainTapeViewController: UIViewController {
	var dataSource: MainTapeDataSourceProtocol?

	private lazy var collection: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collection.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
		collection.backgroundColor = .red
		return collection
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
}

// MARK: - Private method

private extension MainTapeViewController {
	func setupUI() {
		[collection].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview($0)
		}
		setupConstraints()
	}

	func setupConstraints() {
		collection.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalTo(view)
		}
	}
}

// MARK: - MainTapeViewControllerProtocol

extension MainTapeViewController: MainTapeViewControllerProtocol {
	func setItems(_ items: [MainTapeItem]) {
		dataSource?.setItems(items)
	}

	func loadInitialConfiguration() {

	}

	func refresh() {

	}
}
