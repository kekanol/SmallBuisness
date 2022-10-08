//
//  BigPhotoHeader.swift
//  SmallBuisness
//
//  Created by Константин on 08.09.2022.
//

import UIKit

final class BigPhotoHeader: UICollectionReusableView {

	private let factory = FiltersFactory()

	private let imageView = UIImageView()
	private lazy var shimmer: UILabel = {
		let label = UILabel()
		label.text = "no data"
		return label
	}()
	private lazy var okButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(okButtonDidTap), for: .touchUpInside)
		button.setImage(UIImage.checkCircle, for: .normal)
		return button
	}()
	private lazy var cancelButton: UIButton = {
		let button = UIButton()
		button.addTarget(self, action: #selector(cancelButtonDidTap), for: .touchUpInside)
		button.setImage(UIImage.x, for: .normal)
		button.isHidden = true
		return button
	}()
	private lazy var filterView: FilterView = {
		let view = FilterView()
		view.alpha = 1
		return view
	}()
	private var filterViewConstraint = NSLayoutConstraint()

	static let reuseIdentifier = "\(BigPhotoHeader.self)"

	var okButtonTapped: (() -> Void)?
	var cancelButtonTapped: (() -> Void)?

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func configure(_ image: UIImage?) {
		if let image = image {
			imageView.image = image
			imageView.backgroundColor = .clear
			shimmer.isHidden = true
		} else {
			imageView.backgroundColor = .gray
		}
	}
}

private extension BigPhotoHeader {
	func setupUI() {
		addSubview(imageView)
		addSubview(shimmer)
		addSubview(okButton)
		addSubview(cancelButton)
		addSubview(filterView)
		imageView.snp.makeConstraints { make in
			make.top.height.equalToSuperview()
			make.width.equalTo(imageView.snp.height)
		}
		shimmer.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		okButton.snp.makeConstraints { make in
			make.trailing.top.equalToSuperview().inset(16)
			make.width.height.equalTo(20)
		}
		cancelButton.snp.makeConstraints { make in
			make.leading.top.equalToSuperview().inset(16)
			make.width.height.equalTo(20)
		}
		filterView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(imageView)
		}
		filterViewConstraint = filterView.heightAnchor.constraint(equalToConstant: 0)
		filterViewConstraint.isActive = true
	}

	func showFilters(_ filters: [PhotoFilter]) {
		guard let image = imageView.image else { return }
		filterViewConstraint.constant = 60
		filterView.setImage(image, filters)
		filterView.isHidden = false
		DispatchQueue.main.async { [weak self] in
			UIView.animate(withDuration: 0.5) {
				self?.layoutIfNeeded()
			}
		}
	}

	func hideFilters() {
		filterViewConstraint.constant = 0
		DispatchQueue.main.async { [weak self] in
			UIView.animate(withDuration: 0.5) {
				self?.layoutIfNeeded()
			} completion: { [weak self] isFinished in
				if isFinished { self?.filterView.isHidden = true }
			}
		}
	}

	@objc func okButtonDidTap() {
		guard imageView.image != nil else { return }
		okButton.isHidden = true
		cancelButton.isHidden = false
		let filters = factory.loadFilters()
		showFilters(filters)
		okButtonTapped?()
	}

	@objc func cancelButtonDidTap() {
		okButton.isHidden = false
		cancelButton.isHidden = true
		cancelButtonTapped?()
	}
}
