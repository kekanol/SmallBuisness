//
//  ProfileInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 09.11.2022.
//

import Foundation

final class ProfileInteractor {
	private let service: ProfileService
	private let presenter: ProfilePresenter

	init(service: ProfileService, presenter: ProfilePresenter) {
		self.service = service
		self.presenter = presenter
	}

	func fetchPosts() {
		let posts = CurrentUser.shared.posts
		service.loadPosts(with: posts) { [weak self] result in
			self?.presenter.present(result)
		}
	}

	func didUpdateForm(isLongForm: Bool) {
		presenter.updateForm(isLongForm: isLongForm)
	}
}
