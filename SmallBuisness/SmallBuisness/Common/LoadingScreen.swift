//
//  LoadingScreen.swift
//  SmallBuisness
//
//  Created by Константин on 06.10.2022.
//

import UIKit

final class LoadingScreen: UIViewController {
	private let nextViewController: UIViewController?
	private lazy var spiner: Spinner = {
		let size = UIScreen.main.bounds.width / 2
		let origin = CGPoint(x: view.center.x - size / 2, y: view.center.y - size / 2)
		let frame = CGRect(origin: origin, size: CGSize(width: size, height: size))
		let spinner = Spinner(frame: frame, tintColor: .primary, linewidth: 10)
		return spinner
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .elementLine
		view.addSubview(spiner)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		spiner.startAnimating()
	}

	init(_ nextViewController: UIViewController? = nil) {
		self.nextViewController = nextViewController
		super.init(nibName: nil, bundle: nil)
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func loadingEnded() {
		guard let nextViewController = nextViewController else { return }
		navigationController?.pushViewController(nextViewController, animated: true)
	}
}
