//
//  PhotoLibraryAccessor.swift
//  SmallBuisness
//
//  Created by Константин on 30.08.2022.
//

import Photos

final class PhotoLibraryAccessor {

	static let shared = PhotoLibraryAccessor()

	private let key = "PHPhotoLibrary.requestAuthorization"

	private init() {
		let statusRaw = UserDefaults.standard.integer(forKey: key)
		guard let savedStatus = PHAuthorizationStatus.init(rawValue: statusRaw) else {
			status = .notDetermined
			return
		}
		status = savedStatus
	}

	var status: PHAuthorizationStatus

	func requestAccess(_ completion: @escaping ((PHAuthorizationStatus?) -> Void)) {
		guard status == .notDetermined else {
			completion(nil)
			return
		}
		PHPhotoLibrary.requestAuthorization { [weak self] status in
			guard let self = self else {
				completion(nil)
				return
			}
			UserDefaults.standard.set(status.rawValue, forKey: self.key)
			self.status = status
			completion(status)
		}
	}
}
