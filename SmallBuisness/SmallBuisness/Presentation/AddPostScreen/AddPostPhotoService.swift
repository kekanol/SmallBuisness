//
//  AddPostPhotoService.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import UIKit
import Photos

final class AddPostPhotoService {

	private let fetchLimit = 20

	func loadPhotos(_ completion: @escaping ([UIImage]) -> Void) {
		guard PHPhotoLibrary.authorizationStatus() == .authorized else {
			completion([])
			return
		}

		var images = [UIImage]()

		let imgManager = PHImageManager.default()
		let fetchOptions = PHFetchOptions()
		fetchOptions.fetchLimit = fetchLimit
		fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]

		let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)

		let scale = UIScreen.main.scale
		let size = CGSize(width: 100 * scale, height: 100 * scale)
		let options = PHImageRequestOptions()
		options.isSynchronous = true

		for index in 0..<fetchResult.count {
			let asset = fetchResult[index]
			imgManager.requestImage(for: asset,
									targetSize: size,
									contentMode: .aspectFill,
									options: options) { (image, _) in
				if let image = image {
					images.append(image)
				}
			}
		}

		completion(images)
	}
}
