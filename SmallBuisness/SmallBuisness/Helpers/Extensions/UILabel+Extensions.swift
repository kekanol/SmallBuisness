//
//  UILabel+Extensions.swift
//  SmallBuisness
//
//  Created by Константин on 16.10.2022.
//

import UIKit

extension UILabel {
	func calculateMaxLines(for width: CGFloat) -> Int {
		let charSize = font.lineHeight
		let textSize = calculateTextSize(for: width)
		let linesRoundedUp = Int(ceil(textSize.height/charSize))
		return linesRoundedUp
	}

	func calculateTextSize(for width: CGFloat) -> CGSize {
		let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
		let text = (self.text ?? "") as NSString
		let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: self.font], context: nil)
		return textSize.size
	}
}
