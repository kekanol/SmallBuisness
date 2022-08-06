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
		let db = PostCellViewDataBaseService()
		let interactor = PostCellViewInteractor(dataBaseService: db)
		view.interactor = interactor

		return view
	}
}
