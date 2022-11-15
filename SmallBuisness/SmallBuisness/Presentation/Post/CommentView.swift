//
//  CommentView.swift
//  SmallBuisness
//
//  Created by Константин on 11.10.2022.
//

import UIKit

final class CommentView: UIView {

	var likeButtonAction: (() -> Void)?

	private var comment: Comment

	private lazy var image: UIImageView = {
		let view = UIImageView()
		view.layer.cornerRadius = 12
		view.backgroundColor = .clear
		return view
	}()
	private lazy var name: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 12)
		label.textColor = .textPrimary
		return label
	}()
	private lazy var descriptionView: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .regular, of: 12)
		label.numberOfLines = 0
		label.textColor = .textPrimary
		return label
	}()
	private lazy var date: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .regular, of: 10)
		label.textColor = .textTertiary
		return label
	}()
	private lazy var dateImage: UIImageView = {
		let view = UIImageView()
		view.image = .clockOutline
		view.backgroundColor = .clear
		return view
	}()
	private lazy var likeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.heartOutline, for: .normal)
		button.setImage(UIImage.heartFilled.withTintColor(.primary), for: .selected)
		button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
		return button
	}()
	private lazy var likeCount: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 12)
		label.textColor = .textPrimary
		return label
	}()
	private lazy var vStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 4
		return stack
	}()

	init(_ comment: Comment) {
		self.comment = comment
		super.init(frame: .zero)
		setupView()
		configure()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension CommentView {
	func setupView() {
		let dateView = UIView()
		dateView.addSubview(dateImage)
		dateView.addSubview(date)
		let topView = UIView()
		[image, name, likeCount, likeButton].forEach { topView.addSubview($0) }
		[topView, descriptionView, dateView].forEach {
			vStack.addArrangedSubview($0)
		}

		addSubview(vStack)

		vStack.snp.makeConstraints { make in make.leading.trailing.top.bottom.equalToSuperview() }
		dateImage.snp.makeConstraints { make in
			make.leading.top.equalToSuperview()
			make.width.height.equalTo(16)
		}
		date.snp.makeConstraints { make in
			make.leading.equalTo(dateImage.snp.trailing).offset(2)
			make.top.trailing.bottom.equalToSuperview()
		}
		dateView.snp.makeConstraints { make in
			make.height.equalTo(16)
		}
		topView.snp.makeConstraints { make in make.height.equalTo(24) }
		likeButton.snp.makeConstraints { make in
			make.width.height.equalTo(16)
			make.trailing.centerY.equalToSuperview()
		}
		likeCount.snp.makeConstraints { make in
			make.width.equalTo(24)
			make.trailing.equalTo(likeButton.snp.leading).offset(8)
			make.centerY.equalToSuperview()
		}
		image.snp.makeConstraints { make in
			make.leading.centerY.equalToSuperview()
			make.width.height.equalTo(24)
		}
		name.snp.makeConstraints { make in
			make.leading.equalTo(image.snp.trailing).offset(8)
			make.centerY.equalToSuperview()
			make.trailing.equalTo(likeCount.snp.leading)
		}
	}

	func configure() {
		image.loadWithCache(comment.accountImageUrl)
		name.text = comment.accountName
		descriptionView.text = comment.text
		likeButton.isSelected = comment.isLiked
		likeCount.text = "\(comment.likesCount)"
		date.text = comment.date.string(with: "dd MMMM yyyy")
	}

	@objc
	func likeButtonTapped() {
		likeButton.isSelected.toggle()
		comment.isLiked.toggle()
		if comment.isLiked {
			comment.likesCount += 1
		} else {
			comment.likesCount -= 1
		}
		likeCount.text = "\(comment.likesCount)"
		likeButtonAction?()
	}
}
