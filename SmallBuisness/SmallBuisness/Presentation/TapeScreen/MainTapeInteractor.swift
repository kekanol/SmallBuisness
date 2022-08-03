//
//  MainTapeInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

protocol MainTapeInteractorProtocol {
	func refresh(isInitial: Bool)
	func processDidPullToRefresh()
}

final class MainTapeInteractor {
	var presenter: MainTapePresenterProtocol!
	var service: MainTapeServiceProtocol!
}

extension MainTapeInteractor: MainTapeInteractorProtocol {
	func refresh(isInitial: Bool) {
		service.loadPosts { [weak self] posts in
			guard let self = self else { return }
			switch posts {
			case .success(let posts):
				guard let posts = posts else { return }
				self.presenter.presentPosts(posts)

			case .failure(_):
				return
			}
		}
	}

	func processDidPullToRefresh() {

	}
}
