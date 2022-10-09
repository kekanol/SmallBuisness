//
//  ShakeMenu.swift
//  SmallBuisness
//
//  Created by Константин on 09.10.2022.
//

import UIKit

final class ShakeMenu: UIViewController, UITableViewDelegate, UITableViewDataSource {

	private lazy var items: [ShakeMenuItem] = {
		createItems()
	}()

	private lazy var table: UITableView = {
		let table = UITableView(frame: view.bounds, style: .plain)
		table.register(ShakeMenuCell.self, forCellReuseIdentifier: "ShakeMenuCell")
		view.addSubview(table)
		table.delegate = self
		table.dataSource = self
		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		table.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		items.count
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let model = items[indexPath.row]
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShakeMenuCell") as? ShakeMenuCell else {
			return UITableViewCell()
		}
		cell.configure(title: model.title)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		items[indexPath.row].action?()
	}

	private func createItems() -> [ShakeMenuItem] {

		let authorizeFiz: (() -> Void)? = { [weak self] in
			self?.dismiss(animated: true) {
				CurrentUser.shared.createBaseUser()
				AccountProvider.shared.setState(.fizik)
				Router.shared.mainScreenRouter.showMainScreen()
			}
		}
		let authorizeUr: (() -> Void)? = { [weak self] in
			self?.dismiss(animated: true) {
				CurrentUser.shared.createBaseUser()
				AccountProvider.shared.setState(.urik)
				Router.shared.mainScreenRouter.showMainScreen()
			}
		}
		return [ShakeMenuItem(title: "Авторизироваться как физ лицо", action: authorizeFiz),
				ShakeMenuItem(title: "Авторизироваться как юр лицо", action: authorizeUr)]
	}
}

struct ShakeMenuItem {
	let title: String
	let action: (() -> Void)?
}

final class ShakeMenuCell: UITableViewCell {

	private let title = UILabel()

	override var reuseIdentifier: String? {
		"ShakeMenuCell"
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		addSubview(title)
		title.snp.makeConstraints { make in
			make.leading.top.bottom.trailing.equalToSuperview()
		}
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(title: String) {
		self.title.text = title
	}
}
