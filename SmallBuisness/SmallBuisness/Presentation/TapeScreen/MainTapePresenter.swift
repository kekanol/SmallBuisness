//
//  MainTapePresenter.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

protocol MainTapePresenterProtocol {
	func presentPosts(_ posts: [Post], animated: Bool)
}

final class MainTapePresenter {
	var dataSource: MainTapeDataSourceProtocol!
	weak var viewController: MainTapeViewControllerProtocol?
}

extension MainTapePresenter: MainTapePresenterProtocol {
	func presentPosts(_ posts: [Post], animated: Bool) {
		let items = createTapeItems(from: posts)
		dataSource.setItems(items, animated: animated)
	}
}

private extension MainTapePresenter {
	func createTapeItems(from posts: [Post]) -> [PostCellItem] {
		posts.map { post -> PostCellItem in
			return PostCellItem(post: post)
		}
	}
}
