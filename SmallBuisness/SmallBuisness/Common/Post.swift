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
	var date: Date
	var comments: [Comment]
}

struct Comment {
	var accountImageUrl: URL
	var accountName: String
	var text: String
	var isLiked: Bool
	var likesCount: Int
	var date: Date
}

struct Account {
	var imageUrl: URL
	var name: String
	var id: String
}
