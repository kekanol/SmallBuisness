//
//  ProfileSettingsFactory.swift
//  SmallBuisness
//
//  Created by Константин on 30.11.2022.
//

import UIKit

final class ProfileSettingsFactory {
	private var pushesOn: Bool = true
	var pushes: [PushType] = [.likes, .coments, .subs]
	var documents: [Document] = []
	var updateItems: (() -> Void)?

	func generateItems() -> [UIView] {
		var views = [UIView]()
		pushesOn = pushes.count > 0
		let sectionView1 = SettingsTitleView()
		sectionView1.text = "Настройки Push-уведомлений"
		views.append(sectionView1)
		let allPush = PushItem(title: "Push-уведомления", isOn: pushesOn) { [weak self] isOn in
			self?.pushesOn = isOn
			self?.updateItems?()
		}
		let allView = PushView()
		allView.configure(item: allPush, isLast: true)
		views.append(allView)
		PushType.allcases.enumerated().forEach { (index, type) in
			let item = PushItem(title: type.title, isOn: pushes.contains(type)) { [weak self] isOn in
				if isOn {
					self?.pushes.append(type)
				} else {
					guard let coinsedense = self?.pushes.firstIndex(where: { $0 == type }) else { return }
					self?.pushes.remove(at: coinsedense)
				}
				self?.updateItems?()
			}
			let view = PushView()
			view.configure(item: item, isLast: index == PushType.allcases.count - 1)
			views.append(view)
		}
		let sectionView2 = SettingsTitleView()
		sectionView2.text = "дополнительные документы"
		views.append(sectionView2)
		documents.enumerated().forEach { (index, doc) in
			let item = DocumentItem(title: doc.title) {
				guard let url = Router.shared.getDeepLink(fromUrl: doc.url) else { return }
				Router.shared.processDeeplink(url)
			}
			let view = DocumentCellView()
			view.configure(with: item, isLast: index == documents.count - 1)
			views.append(view)
		}
		return views
	}

	enum PushType {
		case likes
		case subs
		case coments

		var title: String {
			switch self {
			case .likes: return "Новые лайки"
			case .subs: return "Новые подписки"
			case .coments: return "Новые упоминания в комментариях"
			}
		}

		static var allcases: [PushType] = [.likes, .subs, .coments]
	}

	struct Document {
		var title: String
		var url: String
	}
}
