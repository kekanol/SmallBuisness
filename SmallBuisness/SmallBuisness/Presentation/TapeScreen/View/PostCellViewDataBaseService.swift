//
//  PostCellViewDataBaseService.swift
//  SmallBuisness
//
//  Created by Константин on 05.08.2022.
//

import UIKit

protocol PostCellViewDataBaseServiceProtocol {
	func getImage(for path: String) -> UIImage?
	func saveImage(image: UIImage, for id: String, imageType: ImageType)
}

final class PostCellViewDataBaseService: PostCellViewDataBaseServiceProtocol {
	func saveImage(image: UIImage, for id: String, imageType: ImageType) {
		let data: Data
		if let jpeg = image.jpegData(compressionQuality: 1) {
			data = jpeg
		} else if let png = image.pngData() {
			data = png
		} else { return }

		guard let directory = try? FileManager.default.url(for: .documentDirectory,
														   in: .userDomainMask,
														   appropriateFor: nil,
														   create: false) as NSURL else { return }
		do {
			try data.write(to: directory.appendingPathComponent(id + imageType.rawValue + ".jpg")!)
			return
		} catch {
			print(error.localizedDescription)
			return
		}
	}

	func getImage(for path: String) -> UIImage? {
		guard let directory = try? FileManager.default.url(for: .documentDirectory,
														   in: .userDomainMask,
														   appropriateFor: nil,
														   create: false) as NSURL else { return nil }
		guard let directoryString = directory.absoluteString else { return nil }
		let dirPath = URL(fileURLWithPath: directoryString)
		return UIImage(contentsOfFile: dirPath.appendingPathComponent(path).path)
	}
}
