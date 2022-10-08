//
//  CollectionDataSource.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

class CollectionDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {

	var collection: UICollectionView

	init(collection: UICollectionView) {
		self.collection = collection
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		return UICollectionViewCell()
	}
}
