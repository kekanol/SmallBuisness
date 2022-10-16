//
//  Date+Extensions.swift
//  SmallBuisness
//
//  Created by Константин on 16.10.2022.
//

import Foundation

extension Date {
	func string(with format: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = format
		return formatter.string(from: self)
	}
}
