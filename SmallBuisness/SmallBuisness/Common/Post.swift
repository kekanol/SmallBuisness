//
//  Post.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

struct Post {
	var id: String
	var account: Account
	var imageUrl: URL
	var isProduct: Bool
	var description: String
	var likeCount: Int
	var isLiked: Bool
	var isFavourite: Bool
	var comments: [Comment]
}

struct Comment {
	var accountImageUrl: URL
	var account: String
	var text: String
}

struct Account {
	var imageUrl: URL
	var name: String
	var id: String
}
