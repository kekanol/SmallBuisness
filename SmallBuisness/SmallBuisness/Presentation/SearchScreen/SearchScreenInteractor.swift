//
//  SearchScreenInteractor.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import Foundation

final class SearchScreenInteractor {
	var presenter: SearchScreenPresenter!
	var service: SearchScreenServiceProtocol!
}

extension SearchScreenInteractor {
	func processScreenAppeared(isInitial: Bool) {
		guard isInitial else { return }
		service.loadData { [weak self] data in
			guard let self = self else { return }
			self.presenter.updateData(data)
		}
	}
}
