//
//  ShortPostCellView.swift
//  SmallBuisness
//
//  Created by Константин on 15.11.2022.
//

import UIKit

final class ShortPostCellView: UIView {

	private let imageView = UIImageView()

	init() {
		super.init(frame: .zero)
		imageView.contentMode = .scaleAspectFill
		imageView.layer.cornerRadius = 8
		imageView.layer.masksToBounds = true
		addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.snp.makeConstraints { make in
			make.leading.trailing.bottom.top.equalToSuperview()
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setItem(_ item: PostCellItem) {
		imageView.sd_setImage(with: item.post.imageUrl)
	}
}
