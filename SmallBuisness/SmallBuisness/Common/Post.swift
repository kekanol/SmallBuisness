//
//  Post.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

struct Post {
	var imageUrl: String
	var isProduct: Bool
	var description: String
	var account: String
	var likeCount: Int
	var isLiked: Bool
	var comments: [Comment]
}

struct Comment {
	var account: String
	var text: String
}
