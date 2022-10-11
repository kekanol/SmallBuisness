//
//  DescriptionPostView.swift
//  SmallBuisness
//
//  Created by Константин on 10.10.2022.
//

import UIKit

final class DescriptionPostView: UIView {
	private let isFromPost: Bool
	private let post: Post

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
		[image, name].forEach { stack.addArrangedSubview($0) }
		stack.axis = .horizontal
		stack.spacing = 8
		stack.contentMode = .left
		return stack
	}()
	private lazy var descriptionView: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .regular, of: 12)
		label.numberOfLines = isFromPost ? 3 : 0
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
	private lazy var vStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 4
		return stack
	}()

	init(fromPost: Bool, post: Post) {
		isFromPost = fromPost
		self.post = post
		super.init(frame: .zero)
		setupView()
		configure()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension DescriptionPostView {
	func setupView() {
		let dateView = UIView()
		dateView.addSubview(dateImage)
		dateView.addSubview(date)
		if isFromPost {
			[hStack, dateView, descriptionView].forEach {
				vStack.addArrangedSubview($0)
			}
		} else {
			image.isHidden = true
			[hStack, descriptionView, dateView].forEach {
				vStack.addArrangedSubview($0)
			}
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
		if !isFromPost {
			let devider = UIView()
			devider.backgroundColor = .elementLine
			vStack.addArrangedSubview(devider)
			devider.snp.makeConstraints { make in make.height.equalTo(1) }
		}
	}

	func configure() {
		//		image.image = coment.accountImageUrl // TODO: добавить картинку
		image.backgroundColor = .gray
		name.text = post.account.name
		descriptionView.text = post.description
		date.text = "\(Date())" // TODO: add date
	}
}
