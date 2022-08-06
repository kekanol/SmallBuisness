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
	func processViewDidAppear()
	func loadDBPosts()
}

final class MainTapeInteractor {
	var presenter: MainTapePresenterProtocol!
	var service: MainTapeServiceProtocol!
	var dbService: MainTapeDataBaseServiceProtocol!

	private var didAppearFirstTime: Bool = true
}

extension MainTapeInteractor: MainTapeInteractorProtocol {
	func refresh(isInitial: Bool) {
		if isInitial {
			loadDBPosts()
		}

		service.loadPosts { [weak self] posts in
			guard let self = self else { return }
			switch posts {
			case .success(let posts):
				guard let posts = posts else { return }
				self.presenter.presentPosts(posts, animated: true)

			case .failure(_):
				return
			}
		}
	}

	func processDidPullToRefresh() {

	}

	func processViewDidAppear() {
		if didAppearFirstTime {
			didAppearFirstTime = false
			refresh(isInitial: true)
		}
	}

	func loadDBPosts() {
		dbService.loadPosts { [weak self] posts in
			guard let self = self else { return }
			self.presenter.presentPosts(posts, animated: false)
		}
	}
}
