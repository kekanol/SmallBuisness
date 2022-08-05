//
//  PostCellView.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellView: UIView {

	var interactor: PostCellViewInteractor!

	var contentHeight: CGFloat = 0

	private lazy var imageView = UIImageView()
	private lazy var accountImage = UIImageView()
	private lazy var accountLabel = UILabel()
	private lazy var threDotsButton = UIButton()
	private lazy var likeButton = UIButton()
	private lazy var favouriteButton = UIButton()
	private lazy var loader = ProgressRing()
	private lazy var descriptionLabel = UILabel()
	private lazy var comentImage = UIImageView()
	private lazy var comentAccountLabel = UILabel()
	private lazy var comentDescription = UILabel()

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setItem(_ item: PostCellItem) {
		imageView.image = nil
		loader.isHidden = false
		interactor.loadImage(with: item.post.imageUrl, imageType: .post) { [weak self] image in
			guard let self = self else { return }
			self.imageView.image = image
			let height = image.size.height / image.size.width * self.frame.width
			self.imageView.snp.remakeConstraints { make in
				make.leading.trailing.equalToSuperview()
				make.top.equalTo(self.accountImage.snp.bottom).offset(8)
				make.height.equalTo(height)
			}
			self.contentHeight = self.contentHeight - self.frame.size.width + height
			self.loader.isHidden = true
		}

		interactor.loadImage(with: item.post.account.imageUrl, imageType: .account) { [weak self] image in
			guard let self = self else { return }
			self.accountImage.image = image
		}

		accountLabel.text = item.post.account.name
		descriptionLabel.text = item.post.description
		likeButton.isSelected = item.post.isLiked
		favouriteButton.isSelected = item.post.isFavourite
	}
}

private extension PostCellView {
	func setupUI() {
		[imageView,
		 accountImage,
		 accountLabel,
		 threDotsButton,
		 likeButton,
		 favouriteButton,
		 loader,
		 descriptionLabel,
//		 comentImage,
//		 comentAccountLabel,
//		 comentDescription
		].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		setupConstraints()
	}

	func setupConstraints() {
		accountImage.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.top.equalToSuperview().offset(8)
			make.width.height.equalTo(20)
		}

		accountLabel.snp.makeConstraints { make in
			make.leading.equalTo(accountImage.snp.trailing).offset(8)
			make.centerY.equalTo(accountImage)
		}

		threDotsButton.snp.makeConstraints { make in
			make.centerY.equalTo(accountImage)
			make.trailing.equalToSuperview().inset(16)
			make.width.height.equalTo(20)
		}

		imageView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(accountImage.snp.bottom).offset(8)
			make.height.equalTo(imageView.snp.width)
		}

		likeButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.width.height.equalTo(16)
			make.top.equalTo(imageView.snp.bottom).offset(8)
		}

		favouriteButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(16)
			make.width.height.equalTo(16)
			make.centerY.equalTo(likeButton)
		}

		descriptionLabel.snp.makeConstraints { make in
			make.leading.equalTo(likeButton)
			make.top.equalTo(likeButton.snp.bottom)
			make.height.equalTo(16)
			make.trailing.equalTo(favouriteButton)
		}

		loader.snp.makeConstraints { make in
			make.center.equalTo(imageView)
			make.width.height.equalTo(50)
		}
	}
}
