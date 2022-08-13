//
//  SearchScreenCell.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import UIKit

final class SearchScreenCell: UICollectionViewCell {
	static let reuseIdentifier: String = "\(SearchScreenCell.self)"

	private let view = SearchScreenCellView()

	private var item: SearchCellItem?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: SearchCellItem) {
		self.item = item
		view.setItem(item)
	}
}

// MARK: - Private methods

private extension SearchScreenCell {
	func setupUI() {
		[view].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		view.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}
}
