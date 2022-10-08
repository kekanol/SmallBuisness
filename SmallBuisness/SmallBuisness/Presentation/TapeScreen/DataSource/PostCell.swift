//
//  PostCell.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

final class PostCell: UITableViewCell {
	static let reuseIdentifier: String = "\(PostCell.self)"

	private let view = PostCellViewAssembly.build()

	private var item: PostCellItem?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: PostCellItem, indexPath: IndexPath) {
		self.item = item
		view.setItem(item, indexPath: indexPath)
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
