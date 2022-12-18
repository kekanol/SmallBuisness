//
//  ProfileSettingsViewController.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class ProfileSettingsViewController: UIViewController {

	private let interactor: ProfileSettingsInteractor
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		return stack
	}()
	private let scroll = UIScrollView()

	init(interactor: ProfileSettingsInteractor) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	@available(*,unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupView()
		interactor.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = false
	}

	func setViews(_ views: [UIView]) {
		views.forEach {
			stackView.addArrangedSubview($0)
		}
	}
}

private extension ProfileSettingsViewController {
	func setupView() {
		scroll.addSubview(stackView)
		view.addSubview(scroll)
		scroll.snp.makeConstraints { make in
			make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
		}
		stackView.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalTo(scroll.contentLayoutGuide)
			make.width.equalTo(scroll.frameLayoutGuide)
		}
	}
}
