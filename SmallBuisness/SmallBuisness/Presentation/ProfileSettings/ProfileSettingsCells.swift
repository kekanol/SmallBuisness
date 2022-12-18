//
//  ProfileSettingsCells.swift
//  SmallBuisness
//
//  Created by Константин on 30.11.2022.
//

import UIKit

struct PushItem {
	let title: String
	let isOn: Bool
	let action: ((Bool) -> Void)
}

final class PushView: UIView {
	private var action: ((Bool) -> Void)?
	private lazy var label: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .semibold, of: 14)
		label.textColor = .textPrimary
		return label
	}()

	private lazy var toggle: UISwitch = {
		let toggle = UISwitch()
		toggle.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
		return toggle
	}()

	private lazy var devider: UIView = {
		let view = UIView()
		view.backgroundColor = .elementLine
		return view
	}()

	init() {
		super.init(frame: .zero)
		setupView()
	}

	@available(*,unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(item: PushItem, isLast: Bool) {
		self.action = item.action
		label.text = item.title
		toggle.isOn = item.isOn
		devider.isHidden = isLast
	}
}

private extension PushView {

	@objc
	func valueChanged() {
		let isOn = toggle.isOn
		action?(isOn)
	}

	func setupView() {
		addSubview(label)
		addSubview(toggle)
		addSubview(devider)
		label.snp.makeConstraints { make in
			make.top.bottom.equalToSuperview().inset(16)
			make.leading.equalToSuperview().offset(12)
			make.trailing.equalTo(toggle.snp.leading)
		}
		toggle.snp.makeConstraints { make in
			make.trailing.equalToSuperview().inset(12)
			make.top.bottom.equalToSuperview().inset(16)
		}
		devider.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.height.equalTo(1)
		}
	}
}

struct TitleItem {
	let title: String
}

final class SettingsTitleView: UIView {
	var text: String = "" {
		didSet {
			label.text = text
		}
	}
	private lazy var label: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .medium, of: 12)
		label.numberOfLines = 1
		label.textColor = .textTertiary
		return label
	}()

	init() {
		super.init(frame: .zero)
		addSubview(label)
		label.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}

	@available(*,unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

struct DocumentItem {
	let title: String
	let action: (() -> Void)
}

final class DocumentCellView: UIView {
	private var action: (() -> Void)?
	private lazy var devider: UIView = {
		let view = UIView()
		view.backgroundColor = .elementLine
		return view
	}()
	private let title = LinkTitle()

	init() {
		super.init(frame: .zero)

		title.addTarget(self, action: #selector(tapped), for: .touchUpInside)

		addSubview(title)
		addSubview(devider)

		title.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.bottom.equalToSuperview().inset(4)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: DocumentItem, isLast: Bool) {
		title.setTitle(item.title)
		self.action = item.action
		devider.isHidden = isLast
	}

	@objc private func tapped() {
		action?()
	}
}

final class LinkTitle: UIControl {
	private lazy var title: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .semibold, of: 14)
		return label
	}()

	override var isHighlighted: Bool {
		didSet {
			title.textColor = isHighlighted ? .secondarySelected : .textPurple
		}
	}

	init() {
		super.init(frame: .zero)
		addSubview(title)
		title.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview().inset(12)
		}
	}

	@available(*,unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setTitle(_ text: String) {
		title.text = text
	}
}
