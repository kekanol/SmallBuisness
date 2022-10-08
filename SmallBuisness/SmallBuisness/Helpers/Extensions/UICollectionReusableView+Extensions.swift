//
//  UICollectionReusableView+Extensions.swift
//  SmallBuisness
//
//  Created by Константин on 03.08.2022.
//

import UIKit

extension UICollectionReusableView {
	static var identifier: String {
		return String(describing: self)
	}
	static var nib: UINib {
		return UINib(nibName: self.identifier, bundle: nil)
	}
}

extension UICollectionView {
	func register<T: UICollectionViewCell>(nib: T.Type) {
		self.register(UINib(nibName: String(describing: nib), bundle: nil), forCellWithReuseIdentifier: String(describing: nib))
	}
	func register<T: UICollectionViewCell>(class cellClass: T.Type) {
		self.register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
	}

	func register<T: UICollectionReusableView>(`class`: T.Type, kind elementKind: String) {
		self.register(`class`, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: `class`.identifier)
	}
}
