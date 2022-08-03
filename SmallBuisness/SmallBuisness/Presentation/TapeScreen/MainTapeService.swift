//
//  MainTapeService.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import Foundation

protocol MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void))
}

final class MainTapeService {

	enum TapeError: Error {
		case noError
	}
}

extension MainTapeService: MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void)) {

	}
}

final class MainTapeServiceMock: MainTapeServiceProtocol {
	func loadPosts(_ completion: @escaping ((Result<[Post]?, Error>) -> Void)) {
		let result = createPosts()
		completion(.success(result))
	}

	private func createPosts() -> [Post] {
		var posts: [Post] = []

		return posts
	}
}
