//
//  PostViewController.swift
//  SmallBuisness
//
//  Created by Константин on 10.10.2022.
//

import UIKit

final class PostViewController: UIViewController {
	private let cellView = PostCellView()
	private let post: Post

	init(item: PostCellItem) {
		post = item.post
		super.init(nibName: nil, bundle: nil)
		cellView.setItem(item)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .secondaryDisabled
		view.addSubview(cellView)
		cellView.snp.makeConstraints { make in
			make.leading.trailing.top.equalToSuperview()
		}
	}
}
