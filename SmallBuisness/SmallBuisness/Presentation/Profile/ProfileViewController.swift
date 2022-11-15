//
//  ProfileViewController.swift
//  SmallBuisness
//
//  Created by Константин on 08.11.2022.
//

import UIKit

final class ProfileViewController: UIViewController {

	var interactor: ProfileInteractor?

	private var isCurrentLong = false {
		didSet {
			updateCollection()
		}
	}

	private lazy var accountLabel: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .bold, of: 16)
		label.textColor = .textPrimary
		return label
	}()

	private lazy var settingsButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.settingsOutline.withTintColor(.primary), for: .normal)
		button.setImage(UIImage.settingsOutline.withTintColor(.primarySelected), for: .highlighted)
		button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
		return button
	}()

	private let header = ProfileHeaderView()

	private lazy var publicationsLabel: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .bold, of: 20)
		label.textColor = .textPrimary
		label.text = "Публикации"
		return label
	}()

	private lazy var longFormButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.horisontal.withTintColor(.textTertiary), for: .normal)
		button.setImage(UIImage.horisontal.withTintColor(.textPrimary), for: .selected)
		button.addTarget(self, action: #selector(formButtonTapped), for: .touchUpInside)
		return button
	}()

	private lazy var shortFormButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.vertical.withTintColor(.textTertiary), for: .normal)
		button.setImage(UIImage.vertical.withTintColor(.textPrimary), for: .selected)
		button.addTarget(self, action: #selector(formButtonTapped), for: .touchUpInside)
		button.isSelected = true
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		let account = CurrentUser.shared.asAccount()
		header.configure(with: account)
		accountLabel.text = account.nickName
		interactor?.fetchPosts()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = true
	}

	func presentPosts(_ posts: [Post]) {
		
	}
}

private extension ProfileViewController {
	@objc func settingsButtonTapped() {
		Router.shared.showProfileSettings()
	}

	@objc func formButtonTapped() {
		longFormButton.isSelected.toggle()
		shortFormButton.isSelected.toggle()
		isCurrentLong.toggle()
	}

	func updateCollection() {

	}

	func setupView() {
		[accountLabel, settingsButton, header, publicationsLabel, longFormButton, shortFormButton].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview($0)
		}

		accountLabel.snp.makeConstraints { make in
			make.leading.top.equalTo(view.safeAreaLayoutGuide).offset(24)
			make.height.equalTo(20)
		}

		settingsButton.snp.makeConstraints { make in
			make.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(24)
			make.width.height.equalTo(32)
		}

		header.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(accountLabel.snp.bottom).offset(22)
		}

		publicationsLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(24)
			make.top.equalTo(header.snp.bottom).offset(24)
		}

		longFormButton.snp.makeConstraints { make in
			make.height.width.equalTo(24)
			make.top.equalTo(publicationsLabel)
		}

		shortFormButton.snp.makeConstraints { make in
			make.leading.equalTo(longFormButton.snp.trailing).offset(8)
			make.trailing.equalToSuperview().inset(24)
			make.height.width.equalTo(24)
			make.top.equalTo(publicationsLabel)
		}
	}
}
