//
//  BottomSheet.swift
//  SmallBuisness
//
//  Created by Константин on 16.10.2022.
//

import UIKit

final class BottomSheet: UIViewController {

	private let baseHeight: CGFloat = 60
	var items = [BottomSheetItem]()
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .bold, of: 16)
		label.textColor = .textPrimary
		return label
	}()
	private lazy var crossButton: UIButton = {
		let button = UIButton()
		button.setImage(UIImage.xOutline16.withTintColor(.black), for: .normal)
		button.setImage(UIImage.xOutline.withTintColor(.textSecondary), for: .selected)
		button.addTarget(self, action: #selector(crossDidTap), for: .touchUpInside)
		return button
	}()
	private lazy var bottomView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 12
		view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
		return view
	}()
	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .equalSpacing
		stack.spacing = 12
		return stack
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		createViews()
		let gr = UITapGestureRecognizer(target: self, action: #selector(crossDidTap))
		view.addGestureRecognizer(gr)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let itemsHeight = CGFloat(items.count * 24) + CGFloat(12 * (items.count - 1))
		let safeAreaHeight = view.safeAreaInsets.bottom
		let totalHeight = baseHeight + itemsHeight + safeAreaHeight
		bottomView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
		UIView.animate(withDuration: 0.15) {
			self.view.layoutSubviews()
		}
	}
}

private extension BottomSheet {
	func setupUI() {
		view.backgroundColor = .trasparentSecondaryBackground
		view.addSubview(bottomView)
		[titleLabel, crossButton, stackView].forEach { bottomView.addSubview($0) }
		titleLabel.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().offset(16)
			make.height.equalTo(20)
		}
		crossButton.snp.makeConstraints { make in
			make.trailing.top.equalToSuperview().inset(16)
			make.width.height.equalTo(16)
		}
		stackView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(16)
			make.top.equalTo(titleLabel.snp.bottom).offset(24)
		}
		bottomView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
		}
	}

	func createViews() {
		for item in items {
			let view = BottomSheetCell()
			view.configure(with: item)
			stackView.addArrangedSubview(view)
		}
	}

	@objc
	func crossDidTap() {
		dismiss(animated: true)
	}
}

final class BottomSheetItem {
	let action: (() -> Void)?
	let image: UIImage
	let title: String
	let tintColor: UIColor

	init(title: String, image: UIImage, tintColor: UIColor = .textPrimary, action: (() -> Void)?) {
		self.title = title
		self.image = image
		self.tintColor = tintColor
		self.action = action
	}
}

final class BottomSheetCell: UIView {
	private let imageView = UIImageView()
	private lazy var title: UILabel = {
		let label = UILabel()
		label.font = .standart(style: .semibold, of: 14)
		label.textColor = .textSecondary
		return label
	}()

	private var tapped: (() -> Void)?

	init() {
		super.init(frame: .zero)
		setup()
		let gr = UITapGestureRecognizer(target: self, action: #selector(itemAction))
		addGestureRecognizer(gr)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(with item: BottomSheetItem) {
		title.text = item.title
		imageView.image = item.image.withTintColor(item.tintColor)
		title.textColor = item.tintColor
		tapped = { [weak item] in item?.action?() }
	}

	private func setup() {
		snp.makeConstraints { make in make.height.equalTo(24) }
		[imageView, title].forEach { addSubview($0) }
		imageView.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.centerY.equalToSuperview()
			make.width.height.equalTo(16)
		}
		title.snp.makeConstraints { make in
			make.leading.equalTo(imageView.snp.trailing).offset(8)
			make.centerY.equalToSuperview()
			make.trailing.equalToSuperview().inset(16)
			make.height.equalTo(16)
		}
	}

	@objc private func itemAction() {
		tapped?()
	}
}

