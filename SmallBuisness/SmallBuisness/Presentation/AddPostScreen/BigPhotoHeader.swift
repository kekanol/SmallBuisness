//
//  BigPhotoHeader.swift
//  SmallBuisness
//
//  Created by Константин on 08.09.2022.
//

import UIKit

final class BigPhotoHeader: UICollectionReusableView {

	private let imageView = UIImageView()
	private lazy var shimmer: UILabel = {
		let label = UILabel()
		label.text = "no data"
		return label
	}()

	static let reuseIdentifier = "\(BigPhotoHeader.self)"

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(_ image: UIImage?) {
		if let image = image {
			imageView.image = image
			imageView.backgroundColor = .clear
			shimmer.isHidden = true
		} else {
			imageView.backgroundColor = .gray
		}
	}
}

private extension BigPhotoHeader {
	func setupUI() {
		addSubview(imageView)
		addSubview(shimmer)
		imageView.snp.makeConstraints { make in
			make.center.height.equalToSuperview()
			make.width.equalTo(imageView.snp.height)
		}
		shimmer.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}
