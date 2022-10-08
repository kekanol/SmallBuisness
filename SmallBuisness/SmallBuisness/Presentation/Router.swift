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
	var currentNC: UINavigationController?

	static let shared = Router()

	private init() {
		currentNC = UIApplication.shared.windows.first?.rootViewController?.navigationController
		currentNC?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.primary]
	}

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
		currentNC?.pushViewController(vc, animated: true)
	}

	func openRegistration() {
		let presenter = RegistrationPresenter()
		let vc = RegistrationNameViewController(presenter: presenter)
		currentNC?.pushViewController(vc, animated: true)
	}
}
