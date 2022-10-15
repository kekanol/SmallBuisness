//
//  UIImage+Extensions.swift
//  SmallBuisness
//
//  Created by Константин on 12.07.2022.
//

import UIKit
import SDWebImage

extension UIImage {
}

extension UIImageView {

	func loadWithCache(_ url: URL) {
		self.sd_setImage(with: url,
						 placeholderImage: nil,
						 options: SDWebImageOptions.waitStoreCache,
						 context: nil)
	}

	func tryLoadWithCache(_ url: String?) {
		self.image = nil
		if let url = url, let url = URL(string: url) {
			self.loadWithCache(url)
		}
	}
}
