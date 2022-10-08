//
//  FilterView.swift
//  SmallBuisness
//
//  Created by Константин on 12.09.2022.
//

import UIKit

final class FilterView: BaseView {
	private(set) lazy var dataSource = FilterViewDataSource(collectionView: collectionView)
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return collection
	}()

	func setImage(_ image: UIImage, _ filters: [PhotoFilter]) {
		dataSource.selectedImage = image
		dataSource.setItems(filters)
	}

	override func setupView() {
		addSubview(collectionView)
		collectionView.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}
}

final class FilterViewCollectionCell: UICollectionViewCell {
	private let imageView = UIImageView()
	private let label = UILabel()
	static let reuseIdentifier = "\(FilterViewCollectionCell.self)"

	func setFilter(on image: UIImage, with filter: PhotoFilter) {
		imageView.image = image
		imageView.layer.addSublayer(filter.layer)
		label.text = filter.name
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(imageView)
		addSubview(label)
		imageView.snp.makeConstraints { make in
			make.leading.trailing.top.equalToSuperview().inset(8)
			make.height.equalTo(imageView.snp.width)
		}
		label.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(8)
			make.bottom.equalToSuperview()
			make.top.equalTo(imageView.snp.bottom).offset(8)
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

final class FilterViewDataSource: DataSource {

	private var filters = [PhotoFilter]() {
		didSet {
			collectionView?.reloadData()
		}
	}

	var selectedImage: UIImage = UIImage()

	func setItems(_ items: [PhotoFilter]) {
		filters = items
	}

	override func configurator(_ indexPath: IndexPath) -> ElementConfigurator {
		let model = filters[indexPath.row]
		return ElementConfigurator(reuseIdentifier: FilterViewCollectionCell.reuseIdentifier) { element in
			guard let cell = element as? FilterViewCollectionCell else { return }
			cell.setFilter(on: self.selectedImage, with: model)
		}
	}
}
