//
//  Router.swift
//  startap777
//
//  Created by Константин on 5/29/22.
//

import UIKit

final class Router {

	private let paths: [String] = []
	private let urlStart: String = "startap777://"
	private let universalStart: String = "https://startap777"
	var currentNC: CommonNavigationController?

	static let shared = Router()

	private init() {}

	func getDeepLink(fromUrl url: String) -> URL? {
		let path = dropUniversalStart(for: url)
		guard let urlString = createLink(for: path) else { return nil }
		return URL(string: urlString)
	}

	func getDeepLink(fromUrl url: URL) -> URL? {
		let path = dropUniversalStart(for: url.absoluteString)
		guard let urlString = createLink(for: path) else { return nil }
		return URL(string: urlString)
	}

	func getDeepLink(fromPath path: String) -> URL? {
		guard let urlString = createLink(for: path) else { return nil }
		return URL(string: urlString)
	}

	func processDeeplink(_ url: URL) {
		guard UIApplication.shared.canOpenURL(url) else { return }
		UIApplication.shared.open(url)
	}

	private func createLink(for string: String) -> String? {
		guard paths.contains(string) else { return nil }
		let link = urlStart + string
		return link
	}

	private func dropUniversalStart(for url: String) -> String {
		if url.localizedStandardContains(universalStart) {
			let newURL = url.dropFirst(universalStart.count)
			return String(newURL)
		}
		return url
	}
}

extension Router {
	var mainScreenRouter: MainScreenRouter {
		MainScreenRouter()
	}

	func openAuthorization() {
		let vc = AuthAssembly().build()
		currentNC?.setViewControllers([vc], animated: true)
	}

	func openRegistration() {
		let presenter = RegistrationPresenter()
		let vc = RegistrationNameViewController(presenter: presenter)
		currentNC?.pushViewController(vc, animated: true)
	}

	func openShakeMenu() {
		guard Constants.devBuild else { return }
		let shakeMenu = ShakeMenu()
		currentNC?.present(shakeMenu, animated: true)
	}

	func showSnackBar(with message: String?, isError: Bool, keyboardHeight: CGFloat = 0) {
		guard let message = message else { return }
		let snackBar = SnackBar(message: message, isError: isError, keyBoardHeight: keyboardHeight)
		snackBar.present(on: currentNC)
	}

	func openComents(for post: Post) {
		let vc = CommentsViewController(post: post)
		currentNC?.pushViewController(vc, animated: true)
	}

	func presentBottomSheet(with items: [BottomSheetItem]) {
		let vc = BottomSheet()
		vc.items = items
		vc.modalPresentationStyle = .overCurrentContext
		vc.modalTransitionStyle = .crossDissolve
		currentNC?.present(vc, animated: false)
	}

	func showProfileSettings() {
		let vc = ProfileSettingsAssembly().build()
		currentNC?.pushViewController(vc, animated: true)
	}

	func openPostInFullScreen(with item: PostCellItem) {
		let viewController = PostViewController(item: item)
		currentNC?.pushViewController(viewController, animated: true)
	}
}
