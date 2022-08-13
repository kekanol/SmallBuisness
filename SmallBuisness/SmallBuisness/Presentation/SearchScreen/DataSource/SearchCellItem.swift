//
//  SearchCellItem.swift
//  SmallBuisness
//
//  Created by Константин on 09.08.2022.
//

import UIKit

final class SearchCellItem {

	var subs: [SubItem] = []

	struct SubItem {
		let framing: SearchCellStackFraming
		let colors: [UIColor] // на сейчас пока так
	}

	func setSubs(with elements: [[(UIColor, Int)]]) {
		guard elements.count == 3 else { return }
		subs.removeAll()
		elements.forEach { sub in
			guard sub.count <= 3, sub.count > 1 else { return }
			let size = sub.map { $0.1 }
			let data = sub.map { $0.0 }
			if size == [2, 1] {
				subs.append(SubItem(framing: .top, colors: data))
			} else if size == [1, 2] {
				subs.append(SubItem(framing: .bot, colors: data))
			} else {
				subs.append(SubItem(framing: .none, colors: data))
			}
		}
	}
}

enum SearchCellStackFraming {
	case top
	case bot
	case none
}
