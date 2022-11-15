//
//  AuthRequest.swift
//  SmallBuisness
//
//  Created by Константин on 04.11.2022.
//

struct AuthRequest: BaseRequest {

	typealias Response = AuthResponseModel

	struct Body: Encodable {

	}

	var path: String = "/authorization"
	var httpMethod: NetworkMethod = .post
	var body: Body

	init(body: Body) {
		self.body = body
	}
}

struct AuthResponseModel: Decodable {

}
