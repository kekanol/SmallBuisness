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

	func settingsButtonDidTap() {
		let items = createSettingsItems()
		Router.shared.presentBottomSheet(with: items)
	}
}

private extension ProfileInteractor {
	func createSettingsItems() -> [BottomSheetItem] {
		let settingsItem = BottomSheetItem(title: "Настройки аккаунта", image: .adjustmentsOutline) {
			Router.shared.showProfileSettings()
		}
		let editProfileItem = BottomSheetItem(title: "Редактировать профиль", image: .edit3) {
			print("edit screen")
		}
		let favouritesItem = BottomSheetItem(title: "Избранное", image: .bookmarkOutline) {
			print("favourites screen")
		}
		let logOutItem = BottomSheetItem(title: "Выйти из аккаунта", image: .ban, tintColor: .error) {
			AccountProvider.shared.setState(.none)
			Router.shared.openAuthorization()
		}
		return [settingsItem, editProfileItem, favouritesItem, logOutItem]
	}
}
