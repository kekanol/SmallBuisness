//
//  MainTapeViewController.swift
//  SmallBuisness
//
//  Created by Константин on 12.07.2022.
//

import UIKit

protocol MainTapeViewControllerProtocol: UIViewController {

	func loadInitialConfiguration()

	func refresh()
}

final class MainTapeViewController: UIViewController {

	var interactor: MainTapeInteractorProtocol!

	lazy var tableView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		let tableView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//		tableView.estimatedRowHeight = UITableView.automaticDimension
		tableView.allowsSelection = false
		return tableView
	}()

	private lazy var spiner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView()
		spinner.hidesWhenStopped = true
		spinner.color = .lightGray
		spinner.style = .large
		spinner.isHidden = true
		return spinner
	}()

	private lazy var topLabel: UILabel = {
		let label = UILabel()
		label.text = "Startap777"
		label.font = .systemFont(ofSize: 18, weight: .medium)
		let gesture = UITapGestureRecognizer(target: self, action: #selector(topLabelDidTap))
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		navigationController?.isNavigationBarHidden = true
		interactor.processViewDidAppear()
	}
}

// MARK: - Private method

private extension MainTapeViewController {

	@objc func topLabelDidTap() {
		tableView.setContentOffset(CGPoint.zero, animated: true)
	}

	func setupUI() {
		[tableView, spiner, topLabel].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview($0)
		}
		setupConstraints()
	}

	func setupConstraints() {
		tableView.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview()
			make.top.equalTo(topLabel.snp.bottom).offset(8)
		}
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

		spiner.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}

		topLabel.snp.makeConstraints { make in
			make.leading.equalToSuperview().offset(16)
			make.height.equalTo(24)
		}
		topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
	}
}

// MARK: - MainTapeViewControllerProtocol

extension MainTapeViewController: MainTapeViewControllerProtocol {

	func loadInitialConfiguration() {}

	func refresh() {

	}
}
