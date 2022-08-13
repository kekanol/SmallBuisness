//
//  SearchScreenPresenter.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import Foundation

final class SearchScreenPresenter {
	weak var viewController: SearchScreenViewController?
	var dataSource: SearchScreenTapeDataSource!
}

extension SearchScreenPresenter {
	func updateData(_ data: [SearchCellItem]) {
		dataSource.setItems(data)
	}
}
