//
//  PostCellView.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellView: UIView {

	var interactor: PostCellViewInteractor!
	var didTapLike: ((IndexPath) -> Void)?
	var didTapComent: ((IndexPath) -> Void)?
	var didTapFavourites: ((IndexPath) -> Void)?

	private lazy var imageHeight = imageView.heightAnchor.constraint(equalTo: widthAnchor)
	private var indexPath: IndexPath = IndexPath()

	private lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.contentMode = .scaleToFill
		return view
	}()

	private lazy var accountImage: UIImageView = {
		let image = UIImageView()
		image.layer.cornerRadius = 10
		image.clipsToBounds = true
		return image
	}()

	private lazy var accountLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16)
		return label
	}()

	private lazy var threDotsButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(threeDotsAction), for: .touchUpInside)
		button.setImage(UIImage.threeDots, for: .normal)
		return button
	}()

	private lazy var likeButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
		button.setImage(UIImage.heartBreak, for: .normal)
		button.setImage(UIImage.heart, for: .selected)
		return button
	}()

	private lazy var comentButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
		button.setImage(UIImage.chatCircle, for: .normal)
		return button
	}()

	private lazy var favouriteButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
		button.setImage(UIImage.heartBreak, for: .normal)
		button.setImage(UIImage.heart, for: .selected)
		return button
	}()

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

	func setItem(_ item: PostCellItem, indexPath: IndexPath) {
		self.indexPath = indexPath
		imageView.image = nil
		loader.isHidden = false
		interactor.loadImage(with: item.post, imageType: .post) { [weak self] image in
			guard let self = self,
			let image = image else { return }
			self.imageView.image = image
			self.loader.isHidden = true
		}

		interactor.loadImage(with: item.post, imageType: .avatar) { [weak self] image in
			guard let self = self else { return }
			self.accountImage.image = image
		}

		accountLabel.text = item.post.account.name
		descriptionLabel.text = item.post.account.name + " " + item.post.description
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
		 comentButton,
		 favouriteButton,
//		 loader,
		 descriptionLabel,
//		 comentImage,
//		 comentAccountLabel,
//		 comentDescription
		].forEach {
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
			make.width.equalTo(imageView.snp.height)
		}

		likeButton.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.width.height.equalTo(16)
			make.top.equalTo(imageView.snp.bottom).offset(8)
		}

		comentButton.snp.makeConstraints { make in
			make.leading.equalTo(likeButton.snp.trailing).offset(16)
			make.width.height.equalTo(16)
			make.centerY.equalTo(likeButton)
		}

		favouriteButton.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(16)
			make.width.height.equalTo(16)
			make.centerY.equalTo(likeButton)
		}

		descriptionLabel.snp.makeConstraints { make in
			make.leading.equalTo(likeButton)
			make.top.equalTo(likeButton.snp.bottom)
			make.height.equalTo(20)
			make.trailing.equalTo(favouriteButton)
			make.bottom.equalToSuperview().inset(8)
		}

//		loader.snp.makeConstraints { make in
//			make.center.equalTo(imageView)
//			make.width.height.equalTo(50)
//		}
	}
}

private extension PostCellView {
	@objc func threeDotsAction() {

	}

	@objc func likeButtonAction() {
		likeButton.isSelected = !likeButton.isSelected
		didTapLike?(indexPath)
	}

	@objc func commentButtonAction() {
		didTapComent?(indexPath)
	}

	@objc func favouriteButtonAction() {
		favouriteButton.isSelected = !favouriteButton.isSelected
		didTapFavourites?(indexPath)
	}
}
