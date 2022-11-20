//
//  ShortPostCell.swift
//  SmallBuisness
//
//  Created by Константин on 15.11.2022.
//

import UIKit

final class ShortPostCell: UICollectionViewCell {
	static let reuseIdentifier: String = "\(ShortPostCell.self)"

	private let view = ShortPostCellView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: PostCellItem) {
		view.setItem(item)
	}

	override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
		return view.point(inside: point, with: event)
	}

	override func becomeFirstResponder() -> Bool {
		view.becomeFirstResponder()
	}
}

// MARK: - Private methods

private extension ShortPostCell {
	func setupUI() {
		addSubview(view)

		view.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.bottom.equalToSuperview()
		}
	}
}
