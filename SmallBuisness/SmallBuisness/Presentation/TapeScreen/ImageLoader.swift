//
//  ImageLoader.swift
//  SmallBuisness
//
//  Created by Константин on 06.08.2022.
//

import Foundation

final class ImageLoader {

	static let shared = ImageLoader()

	private init() { }

	func loadImage(with url: URL, _ completion: @escaping (Data?) -> Void) {
		let task = URLSession.shared.dataTask(with: url) { data, _, _ in
			DispatchQueue.main.async {
				completion(data)
			}
		}
		task.resume()
	}
}
