//
//  SuccessFailView.swift
//  startap777
//
//  Created by Константин on 5/24/22.
//

import UIKit

final class SuccessFailView: UIView {
	private let imageView = UIImageView()
	private let state: State
	private var completion: (() -> Void)?

	static func presentSuccess(on view: UIView, completion: (() -> Void)?) {
		let success = SuccessFailView(with: .success, completion: completion)
		view.addSubview(success)
		success.frame.size = CGSize(width: 100, height: 100)
		success.center = view.center
		success.setup()
	}

	static func presentFailure(on view: UIView, completion: (() -> Void)?) {
		let fail = SuccessFailView(with: .success, completion: completion)
		view.addSubview(fail)
		fail.center = view.center
		fail.setup()
	}

	private init(with state: State, completion: (() -> Void)?) {
		self.state = state
		self.completion = completion
		super.init(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// TODO: - set images
private extension SuccessFailView {
	func setup() {
		switch state {
		case .failure: break
//			imageView.image = UIImage.failImage
		case .success: break
//			imageView.image = UIImage.successImage
		}
		self.alpha = 0
		UIView.animate(withDuration: 0.3) { [weak self] in
			self?.alpha = 1
		} completion: { [weak self] isFinished in
			if isFinished { self?.animate() }
		}
	}

	func animate() {
		UIView.animate(withDuration: 0.3) { [weak self] in
			// do some staff to beautiful animation
		} completion: { [weak self] isFinished in
			if isFinished { self?.deleteSelf() }
		}
	}

	func deleteSelf() {
		UIView.animate(withDuration: 0.1) { [weak self] in
			self?.alpha = 0
		} completion: { [weak self] isFinished in
			if isFinished {
				self?.removeFromSuperview()
				self?.completion?()
			}
		}
	}

	enum State {
		case success
		case failure
	}
}
