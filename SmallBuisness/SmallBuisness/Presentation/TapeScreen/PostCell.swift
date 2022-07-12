//
//  PostCell.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

final class PostCell: UICollectionViewCell {
	static let reuseIdentifier: String = "\(PostCell.self)"

	private let image = UIImageView()

	private var item: PostCellItem

	init(frame: CGRect, item: PostCellItem) {
		self.item = item
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private methods

private extension PostCell {
	func setupUI() {
		[image].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		image.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}
}
