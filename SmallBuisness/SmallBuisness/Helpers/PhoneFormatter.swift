//
//  PhoneFormatter.swift
//  SmallBuisness
//
//  Created by Константин on 08.10.2022.
//

import UIKit

enum PhoneMask {
	case sbprClasic

	var mask: String {
		switch self {
		case .sbprClasic:
			return "+X (XXX) XXX-XX-XX"
		}
	}
}

protocol PhoneFormattable {
	var phoneMask: PhoneMask { get set }
	var inputString: String { get }

	func setInputString(value: String) -> Self
	func isSuitedToPhoneMask(value: String) -> Bool
	func format(prefix: String?) -> String
}

class PhoneFormatter: PhoneFormattable {
	func isSuitedToPhoneMask(value: String) -> Bool {
		return value.clean().count == _phoneMask.mask.clean().count
	}

	private var _formattedString: String = ""
	private var _phoneMask: PhoneMask = .sbprClasic

	var phoneMask: PhoneMask {
		get { _phoneMask }
		set { _phoneMask = newValue }
	}

	var inputString: String {
		get { _formattedString }
		set { _formattedString = newValue }
	}

	func setInputString(value: String) -> Self {
		_formattedString = value
		return self
	}

	func format(prefix: String?) -> String {
		fatalError("Format method should be implemented.")
	}
}

final class TRPhoneFormatter: PhoneFormatter {
	override func format(prefix: String? = nil) -> String {
		let inputString = inputString
		let formaterString: String
		if let prefix = prefix, inputString.hasPrefix(prefix) {
			formaterString = inputString.substring(fromIndex: prefix.count)
		} else {
			formaterString = inputString
		}
		var numbers = formaterString.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
		if numbers == "8" {
			numbers = "7"
		} else if numbers.count == 1, numbers != "7" {
			numbers = "7" + numbers
		}
		var result = ""
		var index = numbers.startIndex

		for ch in phoneMask.mask where index < numbers.endIndex {
			if ch == "X" {
				result.append(numbers[index])
				index = numbers.index(after: index)

			} else {
				result.append(ch)
			}
		}
		var userDefinedPrefix = ""

		if let prefix = prefix, !numbers.isEmpty {
			userDefinedPrefix = prefix
		}

		return userDefinedPrefix + result
	}

	func setCursor(from range: NSRange, with string: String, in textField: UITextField) {
		let index = range.lowerBound
		let offset: Int
		switch index {
		case 0, 1, 2, 3:
			offset = string == "" ? 2 : 5
		case 4, 5, 6, 9, 10, 11, 13, 14, 16, 17:
			offset = string == "" ? index : index + 1
		case 7, 8:
			offset = string == "" ? 7 : 10
		case 12, 15:
			offset = string == "" ? index : index + 2
		default: offset = index
		}
		let beggining = textField.beginningOfDocument
		if let posittion = textField.position(from: beggining, offset: offset) {
			textField.selectedTextRange = textField.textRange(from: posittion, to: posittion)
		}
	}
}

extension String {
	func clean() -> String {
		return self
			.replacingOccurrences(of: " ", with: "")
			.replacingOccurrences(of: "-", with: "")
			.replacingOccurrences(of: "(", with: "")
			.replacingOccurrences(of: ")", with: "")
			.replacingOccurrences(of: "+", with: "")
	}

	func substring(fromIndex: Int) -> String {
		return self[min(fromIndex, count) ..< count]
	}

	subscript (rangeInt: Range<Int>) -> String {
		let range = Range(uncheckedBounds: (lower: max(0, min(count, rangeInt.lowerBound)),
											upper: min(count, max(0, rangeInt.upperBound))))
		let start = index(startIndex, offsetBy: range.lowerBound)
		let end = index(start, offsetBy: range.upperBound - range.lowerBound)
		return String(self[start ..< end])
	}

	subscript (i: Int) -> String {
		return self[i ..< i + 1]
	}

	func substring(toIndex: Int) -> String {
		return self[0 ..< max(0, toIndex)]
	}
}
