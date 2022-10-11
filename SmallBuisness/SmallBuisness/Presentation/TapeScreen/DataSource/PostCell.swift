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
	var didTapLike: ((IndexPath) -> Void)?
	var didTapComent: ((IndexPath) -> Void)?
	var didTapFavourites: ((IndexPath) -> Void)?

	private var item: PostCellItem?

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: PostCellItem, indexPath: IndexPath) {
		self.item = item
		view.setItem(item, indexPath: indexPath)
		view.didTapLike = { [weak self] i in self?.didTapLike?(i) }
		view.didTapComent = { [weak self] i in self?.didTapComent?(i) }
		view.didTapFavourites = { [weak self] i in self?.didTapFavourites?(i) }
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
