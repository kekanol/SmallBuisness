//
//  ProfilePresenter.swift
//  SmallBuisness
//
//  Created by Константин on 09.11.2022.
//

final class ProfilePresenter {
	weak var viewController: ProfileViewController?

	func present(_ posts: [Post]) {
		viewController?.presentPosts(posts)
	}
}
