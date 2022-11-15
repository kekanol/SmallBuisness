//
//  NetworkClient.swift
//  SmallBuisness
//
//  Created by Константин on 06.10.2022.
//

import Foundation

final class NetworkClient {
	private let baseString = "195.2.70.111"
	private let port = "5968"

	func load<T: BaseRequest>(_ request: T, completion: @escaping ((Result<T.Response, NetworkError>) -> Void) ) {
		guard let url = URL(string: baseString + request.path) else {
			completion(.failure(.wrongPath))
			return
		}
		var urlRequest = URLRequest(url: url)
		guard let body = try? JSONEncoder().encode(request.body) else {
			completion(.failure(.bodyError))
			return
		}
		urlRequest.httpBody = body
		urlRequest.httpMethod = request.httpMethod.rawValue
		urlRequest.timeoutInterval = 10
		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			guard let data = data else {
				completion(.failure(.dataError))
				return
			}

			guard let result = try? JSONDecoder().decode(T.Response.self, from: data) else {
				completion(.failure(.responseCast(type: "\(T.Response.self)")))
				return
			}
			completion(.success(result))
		}

		task.resume()
	}
}

protocol BaseRequest {
	associatedtype Response: Decodable
	associatedtype Body: Encodable
	var path: String { get }
	var httpMethod: NetworkMethod { get}
	var body: Body { get }
}

enum NetworkMethod: String {
	case post
	case get
	case patch
	case delete

	var rawValue: String {
		return "\(self)".uppercased()
	}
}

enum NetworkError: Error {
	case wrongPath
	case bodyError
	case dataError
	case responseCast(type: String)

	var message: String {
		switch self {
		case .wrongPath: return "path for url cant be cast to url"
		case .bodyError: return "body for request cant be cast to body"
		case .dataError: return "data in response is nil"
		case .responseCast(let type): return "cant cast data to \(type)"
		@unknown default: return "unknownError"
		}
	}
}
