//
//  SearchScreenViewController.swift
//  SmallBuisness
//
//  Created by Константин on 07.08.2022.
//

import UIKit

final class SearchScreenViewController: UIViewController {

	private var isInitialAppear = true

	var interactor: SearchScreenInteractor!

	lazy var collection: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return collectionView
	}()

	private lazy var header: UILabel = {
		let label = UILabel()
		label.text = "Поиск"
		label.font = .systemFont(ofSize: 24)
		return label
	}()
}

extension SearchScreenViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		interactor.processScreenAppeared(isInitial: isInitialAppear)
		isInitialAppear = false
	}
}

private extension SearchScreenViewController {

	func setupUI() {
		[header, collection].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview($0)
		}
		setupConstraints()
	}

	func setupConstraints() {
		header.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.height.equalTo(30)
		}
		header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true


		collection.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.top.equalTo(header.snp.bottom).offset(16)
		}
	}
}
