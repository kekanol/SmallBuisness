//
//  CommentsViewController.swift
//  SmallBuisness
//
//  Created by Константин on 10.10.2022.
//

import UIKit

final class CommentsViewController: CommonViewController {

	private let post: Post
	private var items: [Comment]

	private lazy var descriptionView = DescriptionPostView(fromPost: false)
	private var bottomConstraint: NSLayoutConstraint!
	private lazy var stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		return stack
	}()
	private lazy var scrollView: UIScrollView = {
		let scroll = UIScrollView()
		scroll.showsHorizontalScrollIndicator = false
		return scroll
	}()
	private lazy var textfield: CommonTextField = {
		let textfield = CommonTextField(isPassword: false)
		textfield.placeholder = "Написать комментарий"
		return textfield
	}()

	init(post: Post) {
		self.post = post
		items = post.comments
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		configure()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(false, animated: true)
		subscribeToKeyboardNotifications()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		unsubscribeFromKeyboardNotifications()
	}

	override func handleKeyboardDidShown(_ keyboardBounds: CGRect) {
		bottomConstraint.constant = -keyboardBounds.height + view.safeAreaInsets.bottom
		UIView.animate(withDuration: 0.15, animations: { [weak self] in
			self?.view.layoutIfNeeded()
		})
	}

	override func handleKeyboardDidHidden(_ keyboardBounds: CGRect) {
		bottomConstraint.constant = 0
		UIView.animate(withDuration: 0.15, animations: { [weak self] in
			self?.view.layoutIfNeeded()
		})
	}
}

private extension CommentsViewController {
	func setupView() {
		view.addSubview(scrollView)
		view.addSubview(textfield)
		scrollView.addSubview(stackView)

		scrollView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(view.safeAreaLayoutGuide)
		}
		textfield.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(24)
			make.top.equalTo(scrollView.snp.bottom)
		}
		stackView.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalTo(scrollView.contentLayoutGuide)
			make.width.equalTo(scrollView.frameLayoutGuide)
		}
		bottomConstraint = textfield.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		bottomConstraint.isActive = true
	}

	func configure() {
		title = "Коментарии"
		view.backgroundColor = .secondaryDisabled
		descriptionView.configure(with: post)
		stackView.addArrangedSubview(descriptionView)
		for item in items {
			let comentView = CommentView(item)
			stackView.addArrangedSubview(comentView)
		}
	}
}
