//
//  PostCell.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

final class PostCell: UICollectionViewCell {
	static let reuseIdentifier: String = "\(PostCell.self)"

	private let view = PostCellViewAssembly.build()

	private var item: PostCellItem?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: PostCellItem) {
		self.item = item
		view.setItem(item)
	}
}

// MARK: - Private methods

private extension PostCell {
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
