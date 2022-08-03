//
//  MainTapePresenter.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

protocol MainTapePresenterProtocol {
	func presentPosts(_ posts: [Post])
}

final class MainTapePresenter {
	var dataSource: MainTapeDataSourceProtocol!
	weak var viewController: MainTapeViewControllerProtocol?
}

extension MainTapePresenter: MainTapePresenterProtocol {
	func presentPosts(_ posts: [Post]) {
		let items = createTapeItems(from: posts)
		dataSource.setItems(items)
	}
}

private extension MainTapePresenter {
	func createTapeItems(from posts: [Post]) -> [PostCellItem] {
		posts.map { post -> PostCellItem in
			return PostCellItem(post: post)
		}
	}
}
