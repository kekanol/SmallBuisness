//
//  PostCellView.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

final class PostCellView: UIView {

	var didTapLike: (() -> Void)?
	var didTapComent: (() -> Void)?
	var didTapFavourites: ((Bool) -> Void)?
	var didTapThreeDots: (() -> Void)?
	var updateHeight: (() -> Void)?

	private var item: PostCellItem!

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
		button.setImage(UIImage.threeDots.withTintColor(.primary), for: .normal)
		return button
	}()

	private lazy var readMoreButton: UIButton = {
		let button = UIButton()
		button.setTitle("посмотреть", for: .normal)
		button.setTitleColor(.textTertiary, for: .normal)
		button.titleLabel?.font = .standart(style: .regular, of: 12)
		button.backgroundColor = .white
		button.layer.cornerRadius = 4
		button.addTarget(self, action: #selector(readMoreButtonAction), for: .touchUpInside)

		button.layer.shadowColor = UIColor.white.cgColor
		button.layer.shadowOpacity = 1
		button.layer.shadowOffset = CGSize(width: -10, height: 2)
		button.layer.shadowRadius = 5

		return button
	}()

	private lazy var likeButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
		button.setImage(UIImage.heartOutline, for: .normal)
		button.setImage(UIImage.heartFilled.withTintColor(.primary), for: .selected)
		return button
	}()

	private lazy var likeCount: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 14)
		label.textColor = .textSecondary
		label.numberOfLines = 1
		return label
	}()

	private lazy var comentButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.chatOutline, for: .normal)
		button.addTarget(self, action: #selector(commentButtonAction), for: .touchUpInside)
		return button
	}()

	private lazy var commentCount: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 14)
		label.textColor = .textSecondary
		label.numberOfLines = 1
		return label
	}()

	private lazy var favouriteButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(favouriteButtonAction), for: .touchUpInside)
		button.setImage(UIImage.bookmarkOutline, for: .normal)
		button.setImage(UIImage.bookmarkFilled, for: .selected)
		return button
	}()

	private var descriptionView: DescriptionPostView

	init() {
		descriptionView = DescriptionPostView(fromPost: true)
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setItem(_ item: PostCellItem) {
		self.item = item
		imageView.loadWithCache(item.post.imageUrl)
		accountImage.loadWithCache(item.post.account.imageUrl)
		accountLabel.text = item.post.account.name
		descriptionView.configure(with: item.post)
		likeButton.isSelected = item.post.isLiked
		likeCount.text = "\(item.post.likeCount)"
		commentCount.text = "\(item.post.comments.count)"
		favouriteButton.isSelected = item.post.isFavourite
		readMoreButton.isHidden = isReadMoreHidden()

		didTapComent = { [weak item] in
			item?.commensAction?()
		}

		didTapLike = { [weak item] in
			item?.likeAction?()
		}

		didTapFavourites = { [weak item] isSelected in
			item?.favouritesAction?(isSelected)
		}

		didTapThreeDots = { [weak item] in
			item?.threeDotsAction?()
		}
	}
}

private extension PostCellView {
	func setupUI() {
		[imageView,
		 accountImage,
		 accountLabel,
		 likeButton,
		 likeCount,
		 comentButton,
		 commentCount,
		 descriptionView,
		 favouriteButton,
		 threDotsButton,
		 readMoreButton
		].forEach {
			addSubview($0)
		}
		setupConstraints()
	}

	func setupConstraints() {
		accountImage.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.top.equalToSuperview().offset(8)
			make.width.height.equalTo(20)
		}

		accountLabel.snp.makeConstraints { make in
			make.leading.equalTo(accountImage.snp.trailing).offset(8)
			make.centerY.equalTo(accountImage)
		}

		threDotsButton.snp.makeConstraints { make in
			make.centerY.equalTo(accountImage)
			make.trailing.equalToSuperview()
			make.width.height.equalTo(24)
		}

		imageView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(accountImage.snp.bottom).offset(8)
			make.width.equalTo(imageView.snp.height)
		}

		likeButton.snp.makeConstraints { make in
			make.leading.equalToSuperview()
			make.width.height.equalTo(24)
			make.top.equalTo(imageView.snp.bottom).offset(10)
		}

		likeCount.snp.makeConstraints { make in
			make.leading.equalTo(likeButton.snp.trailing).offset(4)
			make.centerY.equalTo(likeButton)
			make.height.equalTo(18)
		}

		comentButton.snp.makeConstraints { make in
			make.leading.equalTo(likeCount.snp.trailing).offset(16)
			make.width.height.equalTo(24)
			make.centerY.equalTo(likeButton)
		}

		commentCount.snp.makeConstraints { make in
			make.leading.equalTo(comentButton.snp.trailing).offset(4)
			make.centerY.equalTo(comentButton)
			make.height.equalTo(18)
		}

		favouriteButton.snp.makeConstraints { make in
			make.width.height.equalTo(24)
			make.trailing.equalToSuperview()
			make.centerY.equalTo(likeButton)
		}

		descriptionView.snp.makeConstraints { make in
			make.leading.equalTo(likeButton)
			make.top.equalTo(likeButton.snp.bottom).offset(16)
			make.trailing.equalTo(favouriteButton)
			make.bottom.equalToSuperview().inset(8)
		}

		readMoreButton.snp.makeConstraints { make in
			make.bottom.equalTo(descriptionView).inset(1.5)
			make.trailing.equalTo(descriptionView)
			make.width.equalTo(71)
			make.height.equalTo(12)
		}
	}
}

private extension PostCellView {
	@objc func threeDotsAction() {
		didTapThreeDots?()
	}

	@objc func likeButtonAction() {
		likeButton.isSelected.toggle()
		if likeButton.isSelected {
			item.post.likeCount += 1
		} else{
			item.post.likeCount -= 1
		}
		item.post.isLiked = likeButton.isSelected
		likeCount.text = "\(item.post.likeCount)"
		didTapLike?()
	}

	@objc func commentButtonAction() {
		didTapComent?()
	}

	@objc func favouriteButtonAction() {
		item.post.isFavourite.toggle()
		favouriteButton.isSelected.toggle()
		didTapFavourites?(favouriteButton.isSelected)
	}

	@objc func readMoreButtonAction() {
		item.readMoreTapped = true
		let height = descriptionView.descriptionView
			.calculateTextSize(for: UIConstants.screenWidth - 48).height
		item?.descriptionHeight = height - 28
		updateHeight?()
	}

	func isReadMoreHidden() -> Bool {
		guard !item.readMoreTapped else { return true }
		return descriptionView.descriptionView.calculateMaxLines(for: UIConstants.screenWidth - 48) < 2
	}
}
