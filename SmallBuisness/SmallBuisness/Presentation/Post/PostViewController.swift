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
		cellView.setItem(item, indexPath: IndexPath())
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
		cellView.didTapFavourites = { [weak self] _ in }
		cellView.didTapLike = { [weak self] _ in }
		cellView.didTapComent = { [weak self] _ in
			guard let self = self else { return }
			let vc = CommentsViewController(post: self.post)
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
}
