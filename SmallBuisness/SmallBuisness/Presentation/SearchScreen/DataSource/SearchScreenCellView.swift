//
//  SearchScreenCellView.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import UIKit

final class SearchScreenCellView: UIView {
	private lazy var hStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 0
		return stack
	}()

	init() {
		super.init(frame: .zero)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setItem(_ item: SearchCellItem) {
		if !hStack.subviews.isEmpty { hStack.subviews.forEach { hStack.removeArrangedSubview($0) } }
		let stacks = generateStacks(for: item)
		stacks.forEach { hStack.addArrangedSubview($0) }
	}
}

private extension SearchScreenCellView {
	func setupUI() {
		hStack.translatesAutoresizingMaskIntoConstraints = false
		addSubview(hStack)
		setupConstraints()
	}

	func setupConstraints() {
		hStack.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalToSuperview()
		}
	}

	func generateStacks(for item: SearchCellItem) -> [UIStackView] {
		var stacks = [UIStackView]()
		for element in item.subs {
			let stack = createBaseStackView()
			addViews(to: stack, from: element)
			stacks.append(stack)
		}

		return stacks
	}

	func createBaseStackView() -> UIStackView {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 0
		return stack
	}

	func addViews(to stack: UIStackView, from item: SearchCellItem.SubItem) {
		for (index, element) in item.colors.enumerated() {
			let size: Double
			switch item.framing {
			case .none:
				size = 1
			case .top:
				size = index == 0 ? 2 : 1
			case .bot:
				size = index == 1 ? 2 : 1
			}
			addView(of: size, and: element, to: stack)
		}
	}

	func addView(of size: Double, and color: UIColor, to stackView: UIStackView) {
		let view = UIView()
		view.backgroundColor = color
		view.translatesAutoresizingMaskIntoConstraints = false
		stackView.addArrangedSubview(view)
		view.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: CGFloat(size / 3)).isActive = true
	}
}
