//
//  StretchyHeaderLayout.swift
//  SmallBuisness
//
//  Created by Константин on 12.09.2022.
//

import UIKit

final class StretchyHeaderLayout: UICollectionViewFlowLayout {

	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

		let layoutAttributes = super.layoutAttributesForElements(in: rect)

		layoutAttributes?.forEach({ (attributes) in

			if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
				guard let collectionView = collectionView else { return }

				let contentOffsetY = collectionView.contentOffset.y

				if contentOffsetY < 0 { return }

				var height = attributes.frame.height - contentOffsetY
				if height < collectionView.frame.width / 3 { height = collectionView.frame.width / 3 }

				attributes.frame = CGRect(x: 0, y: contentOffsetY, width: collectionView.frame.width, height: height)
			}
		})

		return layoutAttributes
	}

	override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
		return true
	}
}

