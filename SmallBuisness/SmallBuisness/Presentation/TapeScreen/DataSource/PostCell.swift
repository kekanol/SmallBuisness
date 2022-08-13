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

	var sizeDidChange: ((IndexPath) -> Void)?

	override var intrinsicContentSize: CGSize {
		return CGSize(width: UIScreen.main.bounds.width, height: view.contentHeight)
	}

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
		view.sizeDidChange = { [weak self] indexPath in
			self?.sizeDidChange?(indexPath)
		}
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
