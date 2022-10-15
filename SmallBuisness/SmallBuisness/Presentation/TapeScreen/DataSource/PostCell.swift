//
//  PostCell.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

final class PostCell: UICollectionViewCell {
	static let reuseIdentifier: String = "\(PostCell.self)"

	var updateHeight: (() -> Void)?

	private let view = PostCellView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: PostCellItem, indexPath: IndexPath) {
		view.setItem(item)
		view.updateHeight = { [weak self] in
			self?.updateHeight?()
		}
	}

	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		return view.point(inside: point, with: event)
	}

	override func becomeFirstResponder() -> Bool {
		view.becomeFirstResponder()
	}
}

// MARK: - Private methods

private extension PostCell {
	func setupUI() {
		addSubview(view)

		view.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.bottom.equalToSuperview()
		}
	}
}
