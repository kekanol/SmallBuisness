//
//  AddPostViewController.swift
//  SmallBuisness
//
//  Created by Константин on 29.08.2022.
//

import UIKit

final class AddPostViewController: UIViewController {
	var interactor: AddPostInteractor!

	private(set) lazy var collection: UICollectionView = {
		let layout = StretchyHeaderLayout()
		layout.scrollDirection = .vertical
		layout.sectionHeadersPinToVisibleBounds = false
		let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
		return view
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		interactor.processViewAppeared()
	}
}

extension AddPostViewController {
	func presentError(with error: PhotosError) {
		let alert = UIAlertController(title: error.title, message: error.subtitle, preferredStyle: .alert)
		let ok = UIAlertAction(title: "OK", style: .default) { _ in
			error.okButtonAction?()
		}
		alert.addAction(ok)
		if let cancelAction = error.cancelButtonAction {
			let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
				cancelAction()
			}
			alert.addAction(cancel)
		}

		present(alert, animated: true)
	}
}

private extension AddPostViewController {
	func setupUI() {
		view.addSubview(collection)
		collection.translatesAutoresizingMaskIntoConstraints = false

		collection.snp.makeConstraints { make in
			make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
		}
	}
}

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
