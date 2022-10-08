//
//  PhotoCell.swift
//  SmallBuisness
//
//  Created by Константин on 08.09.2022.
//

import UIKit

final class PhotoCell: UICollectionViewCell {

	static let reuseIdentifier: String = "\(PhotoCell.self)"

	let imageView = UIImageView()
	private lazy var shimmer: UIView = {
		let view = UIView()
		view.backgroundColor = .gray
		return view
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(image: UIImage) {
		shimmer.isHidden = true
		imageView.image = image
	}
}

private extension PhotoCell {
	func setupUI() {
		addSubview(imageView)
		addSubview(shimmer)

		imageView.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}

		shimmer.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}
}
