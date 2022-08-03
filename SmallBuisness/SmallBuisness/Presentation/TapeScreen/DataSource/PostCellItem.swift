//
//  PostCellItem.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import Foundation

final class PostCellItem {

	var post: Post
	var tapAction: (() -> Void)?

	init(post: Post) {
		self.post = post
	}
}
