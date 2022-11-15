//
//  ProfileHeaderView.swift
//  SmallBuisness
//
//  Created by Константин on 08.11.2022.
//

import UIKit

final class ProfileHeaderView: UIView {
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 32
		imageView.clipsToBounds = true
		return imageView
	}()

	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 16)
		label.textColor = .textPrimary
		return label
	}()

	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .regular, of: 14)
		label.textColor = .textPrimary
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		return label
	}()

	private let posts = Counter()
	private let subs = Counter()
	private let suberbs = Counter()

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with account: Account) {
		imageView.sd_setImage(with: account.imageUrl)
		posts.configure(top: "\(account.posts.count)", bottom: "посты")
		subs.configure(top: "\(account.subs.count)", bottom: "подписчики")
		suberbs.configure(top: "\(account.suberbs.count)", bottom: "подписки")
		nameLabel.text = account.name
		descriptionLabel.text = account.description
	}
}

private extension ProfileHeaderView {
	func setupUI() {
		let devider = UIView()
		devider.backgroundColor = .elementLine
		[imageView, posts, subs, suberbs, nameLabel, descriptionLabel, devider].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}

		imageView.snp.makeConstraints { make in
			make.leading.top.equalToSuperview()
			make.width.height.equalTo(64)
		}

		posts.snp.makeConstraints { make in
			make.leading.equalTo(imageView.snp.trailing).offset(24)
			make.centerY.equalTo(imageView)
		}

		subs.snp.makeConstraints { make in
			make.leading.equalTo(posts.snp.trailing).offset(12)
			make.centerY.equalTo(imageView)
		}

		suberbs.snp.makeConstraints { make in
			make.leading.equalTo(subs.snp.trailing).offset(12)
			make.centerY.equalTo(imageView)
		}

		nameLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(imageView.snp.bottom).offset(8)
		}

		descriptionLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.bottom.equalToSuperview().inset(1)
			make.top.equalTo(nameLabel.snp.bottom).offset(4)
		}

		devider.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(1)
		}
	}
}

private extension ProfileHeaderView {
	final class Counter: UIView {
		private lazy var topLabel: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.font = .standart(style: .medium, of: 16)
			label.textColor = .textPrimary
			label.textAlignment = .center
			return label
		}()

		private lazy var bottomLabel: UILabel = {
			let label = UILabel()
			label.translatesAutoresizingMaskIntoConstraints = false
			label.font = .standart(style: .regular, of: 14)
			label.textColor = .textPrimary
			label.textAlignment = .center
			return label
		}()

		init() {
			super.init(frame: .zero)
			setupUI()
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		func configure(top: String, bottom: String) {
			topLabel.text = top
			bottomLabel.text = bottom
		}

		private func setupUI() {
			addSubview(topLabel)
			addSubview(bottomLabel)

			topLabel.snp.makeConstraints { make in
				make.top.leading.trailing.equalToSuperview()
			}
			bottomLabel.snp.makeConstraints { make in
				make.leading.trailing.bottom.equalToSuperview()
				make.top.equalTo(topLabel.snp.bottom).offset(2)
			}
		}
	}
}
