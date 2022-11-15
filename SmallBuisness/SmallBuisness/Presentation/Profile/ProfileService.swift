//
//  ProfileService.swift
//  SmallBuisness
//
//  Created by Константин on 09.11.2022.
//

import Foundation

final class ProfileService {
	func loadPosts(with ids: [String], completion: @escaping ([Post]) -> Void) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			completion([])
		}
	}
}
