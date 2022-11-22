//
//  ProfileDataSource.swift
//  SmallBuisness
//
//  Created by Константин on 15.11.2022.
//

import UIKit

final class ProfileDataSource: DataSource {

	private let placeHolderImage = UIImageView(image: UIImage.cameraOutline)
	private let placeHolderLabel: UILabel = {
		let label = UILabel()
		label.text = "Нет публикаций"
		label.font = .standart(style: .medium, of: 16)
		label.textColor = .textTertiary
		return label
	}()

	private var items: [PostCellItem] = []
	var isLongForm: Bool = false {
		didSet {
			collectionView?.reloadData()
		}
	}

	func setItems(_ posts: [PostCellItem]) {
		items = posts
		placeHolderLabel.isHidden = !items.isEmpty
		placeHolderImage.isHidden = !items.isEmpty
		collectionView?.reloadData()
	}

	override func registerCells() {
		collectionView?.register(PostCell.self, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
		collectionView?.register(ShortPostCell.self, forCellWithReuseIdentifier: ShortPostCell.reuseIdentifier)
	}

	required init(collectionView: UICollectionView) {
		super.init(collectionView: collectionView)

		[placeHolderLabel, placeHolderImage].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			collectionView.addSubview($0)
		}

		placeHolderImage.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalTo(collectionView.snp.centerY)
			make.height.width.equalTo(64)
		}

		placeHolderLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(placeHolderImage.snp.bottom)
		}
	}

	@available(*, unavailable)
	required init(tableView: UITableView) {
		fatalError("init(tableView:) has not been implemented")
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = items[indexPath.row]
		if isLongForm {
			return ElementConfigurator(reuseIdentifier: PostCell.reuseIdentifier, configurationBlock: { (cell) in
				guard let cell = cell as? PostCell else { return }
				cell.configure(with: model, indexPath: indexPath)
				cell.updateHeight = { [weak self] in
					self?.collectionView?.reloadData()
				}
			})
		} else {
			return ElementConfigurator(reuseIdentifier: ShortPostCell.reuseIdentifier, configurationBlock: { (cell) in
				guard let cell = cell as? ShortPostCell else { return }
				cell.configure(with: model)
			})
		}
	}

	override func rowAction(_ indexPath: IndexPath) {
		if !isLongForm {
			Router.shared.openPostInFullScreen(with: items[indexPath.row])
		}
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

	override func sizeForItem(_ indexPath: IndexPath) -> CGSize {
		if isLongForm {
			let item = items[indexPath.row]
			return item.cellSize
		} else {
			guard let collection = collectionView else { return CGSize() }
			let width = (collection.frame.width - 64) / 3
			return CGSize(width: width, height: width)
		}
	}

	override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		12
	}
}
