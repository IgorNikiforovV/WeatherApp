//
//  AccountSummaryViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 06.10.2023.
//

import UIKit

final class AccountSummaryViewController: UIViewController {

	struct Profile {
		let firstName: String
		let lastName: String
	}
	
	var profile: Profile?
	var accounts = [AccountSummaryCell.ViewModel]()
	
	let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()

		setup()
		setupTableHeaderView()
		fetchData()
	}
}

// MARK: Private mathods

private extension AccountSummaryViewController {
	func setup() {
		setupTableView()
	}
	
	func setupTableView() {
		tableView.backgroundColor = appColor
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
		tableView.rowHeight = AccountSummaryCell.rowHeight
		tableView.tableFooterView = UIView()
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
		])
	}
	
	func setupTableHeaderView() {
		let header = AccountSummaryHeaderView(frame: .zero)
		var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = UIScreen.main.bounds.width
		header.frame.size = size
		
		tableView.tableHeaderView = header
	}
	
	func fetchData() {
		accounts = AccountsRepository().fetchAccounts()
	}
}

// MARK: UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		accounts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath)
		if let cell = cell as? AccountSummaryCell {
			cell.configure(with: accounts[indexPath.item])
		}
		return cell
	}
}

// MARK: UITableViewDelegate

extension AccountSummaryViewController: UITableViewDelegate {
	
}

// MARK: Actions

extension AccountSummaryViewController {
	@objc func logoutTapped(sender: UIButton) {
		//NotificationCenter.default.post(name: .logout, object: nil)
	}
	
	@objc func refreshContent() {
//		reset()
//		setupSkeletons()
//		tableView.reloadData()
//		fetchData()
	}
}
