//
//  SearchScreenService.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import Foundation
import UIKit

protocol SearchScreenServiceProtocol {
	func loadData(_ completion: @escaping ( ([SearchCellItem]) -> Void))
}

final class SearchScreenService: SearchScreenServiceProtocol {
	func loadData(_ completion: @escaping ( ([SearchCellItem]) -> Void)) {
	}
}

final class SearchScreenServiceMock: SearchScreenServiceProtocol {
	func loadData(_ completion: @escaping ( ([SearchCellItem]) -> Void)) {
		let data = createMocks()
		completion(data)
	}

	private func createMocks() -> [SearchCellItem] {
		var data = [SearchCellItem]()
		for _ in 0...5 {
			data.append(createItem())
		}
		return data
	}

	private func createItem() -> SearchCellItem {
		let item = SearchCellItem()
		var subs = [[(UIColor, Int)]]()
		for _ in 0...2 {
			let randomSet: Int = [1, 2, 3].randomElement()!
			let firstColor = randomColor()
			let secondColor = randomColor()
			switch randomSet {
			case 1:
				subs.append([(firstColor, 1), (secondColor, 2)])
			case 2:
				subs.append([(firstColor, 2), (secondColor, 1)])
			default:
				let thirdColor = randomColor()
				subs.append([(firstColor, 1), (secondColor, 1), (thirdColor, 1)])
			}
		}
		item.setSubs(with: subs)
		return item
	}

	func randomColor() -> UIColor {
		let colors: [UIColor] = [
			.red,
			.yellow,
			.black,
			.green,
			.blue,
			.brown,
			.cyan,
			.systemPink
		]

		return colors.randomElement()!
	}
}
