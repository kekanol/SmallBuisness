//
//  PostCellViewAssembly.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import Foundation

final class PostCellViewAssembly {
	static func build() -> PostCellView {
		let view = PostCellView()
		let service = PostCellViewServiceMock()
		let db = PostCellViewDataBaseServiceMock()
		let interactor = PostCellViewInteractor(service: service, dataBaseService: db)
		view.interactor = interactor

		return view
	}
}
