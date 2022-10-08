//
//  FiltersFactory.swift
//  SmallBuisness
//
//  Created by Константин on 12.09.2022.
//

import UIKit

struct PhotoFilter {
	var layer: CALayer
	var name: String
}

final class FiltersFactory {
	func loadFilters() -> [PhotoFilter] {
		return createMocks()
	}

	private func createMocks() -> [PhotoFilter] {
		var filters = [PhotoFilter]()
		for index in 0...10 {
			let name = "filter \(index)"
			let layer = CALayer()
			layer.backgroundColor = .init(red: 1 / CGFloat(index),
										  green: 1 / 10 * CGFloat(index),
										  blue: 1,
										  alpha: 0.1)
			let filter = PhotoFilter(layer: layer, name: name)
			filters.append(filter)
		}
		return filters
	}
}
