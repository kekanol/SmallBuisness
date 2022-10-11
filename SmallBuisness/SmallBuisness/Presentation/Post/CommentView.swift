//
//  CommentView.swift
//  SmallBuisness
//
//  Created by Константин on 11.10.2022.
//

import UIKit

final class CommentView: UIView {

	var likeButtonAction: (() -> Void)?

	private let comment: Comment

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
	private lazy var hStack: UIStackView = {
		let stack = UIStackView()
		[image, name, likeCount, likeButton].forEach { stack.addArrangedSubview($0) }
		stack.axis = .horizontal
		stack.spacing = 8
		stack.distribution = .equalSpacing
		return stack
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
		view.image = UIImage() // clock
		view.backgroundColor = .clear
		return view
	}()
	private lazy var likeButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.heart, for: .normal)
		button.setImage(UIImage.heart, for: .selected)
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
		[hStack, descriptionView, dateView].forEach {
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
		hStack.snp.makeConstraints { make in make.height.equalTo(24) }
		likeButton.snp.makeConstraints { make in make.width.height.equalTo(16) }
		likeCount.snp.makeConstraints { make in make.width.equalTo(24) }
	}

	func configure() {
//		image.image = coment.accountImageUrl // TODO: добавить картинку
		image.backgroundColor = .gray
		name.text = comment.account
		descriptionView.text = comment.text
		likeCount.text = String(Int.random(in: 0...999)) //TODO: add count
		date.text = "\(Date())" // TODO: add date
	}

	@objc
	func likeButtonTapped() {
		likeButton.isSelected.toggle()
		likeButtonAction?()
	}
}
