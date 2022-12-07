//
//  ProfileSettingsViewController.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class ProfileSettingsViewController: UIViewController {

	private let interactor: ProfileSettingsInteractor

	private(set) lazy var table: UITableView = {
		let table = UITableView(frame: view.frame, style: .insetGrouped)
		table.translatesAutoresizingMaskIntoConstraints = false
		return table
	}()

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
		setupView()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.isNavigationBarHidden = false
	}
}

private extension ProfileSettingsViewController {
	func setupView() {
		view.addSubview(table)
		table.snp.makeConstraints { make in
			make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
		}
	}
}
