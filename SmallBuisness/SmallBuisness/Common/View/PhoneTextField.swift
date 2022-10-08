//
//  PhoneTextField.swift
//  SmallBuisness
//
//  Created by Константин on 08.10.2022.
//

import UIKit

final class PhoneTextField: CommonTextField {
	let phoneFormatter = TRPhoneFormatter()

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let text = textField.text else { return false }
		let newString = (text as NSString).replacingCharacters(in: range, with: string)
		textField.text = phoneFormatter.setInputString(value: newString).format(prefix: nil)
		phoneFormatter.setCursor(from: range, with: string, in: textField)
		self.text = textField.text
		textChanged?(textField.text)
		return false
	}

	override func setText(_ text: String) {
		textField.text = phoneFormatter.setInputString(value: text).format(prefix: nil)
		textChanged?(textField.text)
	}
}
