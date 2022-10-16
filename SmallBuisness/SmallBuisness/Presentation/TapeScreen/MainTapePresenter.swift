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
	var dataSource: MainTapeDataSource!
	weak var viewController: MainTapeViewControllerProtocol?
	var userDefaults = UserDefaults.standard
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
			let item = PostCellItem(post: post)
			item.commensAction = {
				Router.shared.openComents(for: post)
			}
			item.favouritesAction = { [weak self, weak item] isSelected in
				guard let item = item else { return }
				if isSelected {
					self?.addToFavourites(item: item)
				} else {
					self?.removeFromFavourites(item: item)
				}
			}
			item.threeDotsAction = { [weak self, weak item] in
				guard let item = item,
					  let items = self?.createItemsForBottomSheet(for: item) else { return }
				Router.shared.presentBottomSheet(with: items)
			}
			item.post.isFavourite = isItemFavourite(item)
			return item
		}
	}

	func addToFavourites(item: PostCellItem) {
		if var ids = userDefaults.array(forKey: UserdefaultsKeys.favourites.rawValue) as? [String] {
		ids.append(item.post.id)
		userDefaults.set(ids, forKey: UserdefaultsKeys.favourites.rawValue)
		} else {
			userDefaults.set([item.post.id], forKey: UserdefaultsKeys.favourites.rawValue)
		}
	}

	func removeFromFavourites(item: PostCellItem) {
		var ids = userDefaults.array(forKey: UserdefaultsKeys.favourites.rawValue) as? [String]
		ids?.removeAll(where: { id in
			id == item.post.id
		})
		userDefaults.set(ids, forKey: UserdefaultsKeys.favourites.rawValue)
	}

	func isItemFavourite(_ item: PostCellItem) -> Bool {
		guard let ids = userDefaults.array(forKey: UserdefaultsKeys.favourites.rawValue)
				as? [String] else { return false }
		return ids.contains(item.post.id)
	}

	func createItemsForBottomSheet(for item: PostCellItem) -> [BottomSheetItem] {
		let shareItem = BottomSheetItem(title: "Поделиться", image: .link, action: nil)
		let cancelItem = BottomSheetItem(title: "Отменить подписку", image: .minusCircleOutline, action: nil)
		let banItwm = BottomSheetItem(title: "Подать жалобу", image: .ban, tintColor: .red, action: nil)

		return [shareItem, cancelItem, banItwm]
	}
}
