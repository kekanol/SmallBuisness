//
//  PostCellItem.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

final class PostCellItem {

	var post: Post
	var tapAction: (() -> Void)?
	var likeAction: (() -> Void)?
	var favouritesAction: (() -> Void)?
	var commensAction: (() -> Void)?
	var readMoreTapped = false
	var cellSize: CGSize {
		let height = 506 - 390 + UIConstants.screenWidth + descriptionHeight
		return CGSize(width: UIConstants.screenWidth, height: height)
	}
	var descriptionHeight: CGFloat = 0

	init(post: Post) {
		self.post = post
	}
}
