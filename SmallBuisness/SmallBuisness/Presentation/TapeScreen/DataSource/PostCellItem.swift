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

	init(post: Post) {
		self.post = post
	}

	func calculateCellSize(for width: CGFloat) -> CGSize {
		let avatarHeight = 20
		let avatarSpacingTop = 8
		let avatarSpacingBottom = 8
		let imageHeight = width
		let likeHeight = 16
		let likeSpacingTop = 8
		let likeSpacingBot = 8
		let descriptionHeight = 20 //post.description.width / width int + 1 * 20

		let totalHeight: CGFloat = CGFloat(avatarHeight + avatarSpacingTop + avatarSpacingBottom +
											 likeHeight + likeSpacingBot + likeSpacingTop + descriptionHeight) + imageHeight

		return CGSize(width: width, height: totalHeight)
	}
}
