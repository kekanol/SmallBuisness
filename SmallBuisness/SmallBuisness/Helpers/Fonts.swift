//
//  Fonts.swift
//  SmallBuisness
//
//  Created by Константин on 05.10.2022.
//

import UIKit

extension UIFont {
	static func standart(style: StandartFontName, of size: CGFloat) -> UIFont {
		UIFont(name: style.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
	}

	enum StandartFontName: String {
		case bold = "SFProText-Bold"
		case regular = "SFProText-Regular"
		case semibold = "SFProText-Semibold"
		case medium = "SFProText-Medium"
	}
}
