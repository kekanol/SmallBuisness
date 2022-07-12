//
//  MainTapeItem.swift
//  SmallBuisness
//
//  Created by Константин Емельянов on 31.07.2022.
//

import UIKit

class MainTapeItem: NSObject {
	var tapAction: (() -> Void)?
	var title: String?
}
