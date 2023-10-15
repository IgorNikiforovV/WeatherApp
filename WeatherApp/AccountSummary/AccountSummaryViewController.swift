//
//  AccountSummaryViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 06.10.2023.
//

import UIKit

final class AccountSummaryViewController: UIViewController {
	
	// Request Models
	private(set) var profile: Profile?
	private(set) var accounts = [Account]()
	
	// View Models
	var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome", name: "", date: Date())
	var accountCellViewModels = [AccountSummaryCell.ViewModel]()

	lazy var logoutBarButtonItem: UIBarButtonItem = {
		let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
		barButtonItem.tintColor = .label
		return barButtonItem
	}()
	
	// Components
	let tableView = UITableView()
	let headerView = AccountSummaryHeaderView(frame: .zero)
	let refreshControl = UIRefreshControl()
	
	private var isLoaded = false

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}
}

// MARK: Private mathods

private extension AccountSummaryViewController {
	func setup() {
		setupNavigationBar()
		setupTableView()
		setupTableHeaderView()
		setupRefreshControl()
		setupSkeletons()
		fetchData()
	}
	
	func setupNavigationBar() {
		navigationItem.rightBarButtonItem = logoutBarButtonItem
	}
	
	func setupTableView() {
		tableView.backgroundColor = appColor
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseIdentifier)
		tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseIdentifier)

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
		var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
		size.width = UIScreen.main.bounds.width
		headerView.frame.size = size
		
		tableView.tableHeaderView = headerView
	}
	
	func setupRefreshControl() {
		tableView.refreshControl?.tintColor = appColor
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
	}
	
	func setupSkeletons() {
		let row = Account.makeSkeleton()
		accounts = Array(repeating: row, count: 10)
		configureTableCells(with: accounts)
	}
	
	func reset() {
		profile = nil
		accounts = []
		isLoaded = false
	}
	
	func showErrorAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default))
		present(alert, animated: true)
	}
	
	func displayError(_ error: NetworkError) {
		switch error {
		case .serverError:
			self.showErrorAlert(title: "Server Error", message: "Ensure you are connected to the internet. Please try again.")
		case .decodingError:
			self.showErrorAlert(title: "Decoding Error", message: "We could not precess your request. Please try again.")
		}
	}
	
//	func fetchAccounts() {
//		accountCellViewModels = AccountsRepository().fetchAccounts()
//	}
}

// MARK: UITableViewDataSource

extension AccountSummaryViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		accountCellViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard isLoaded else {
			let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseIdentifier, for: indexPath)
			return cell
		}
		
		let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseIdentifier, for: indexPath)
		if let cell = cell as? AccountSummaryCell {
			cell.configure(with: accountCellViewModels[indexPath.item])
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
		NotificationCenter.default.post(name: .logout, object: nil)
	}
	
	@objc func refreshContent() {
		reset()
		setupSkeletons()
		tableView.reloadData()
		fetchData()
	}
}

// MARK: Networking
private extension AccountSummaryViewController {
	func fetchData() {
		let group = DispatchGroup()
		
		// Testing - random number selection
		let userId = String(Int.random(in: 1..<4))

		group.enter()
		fetchProfile(forUserId: userId) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let profile):
				self.profile = profile
			case .failure(let error):
				displayError(error)
			}
			group.leave()
		}
		
		group.enter()
		fetchAccounts(forUserId: userId) { [weak self] result in
			guard let self else { return }
			switch result {
			case .success(let accounts):
				self.accounts = accounts
			case .failure(let error):
				displayError(error)
			}
			group.leave()
		}
		
		group.notify(queue: .main) {
			self.refreshControl.endRefreshing()
			
			guard let profile = self.profile else { return }
			self.isLoaded = true
			self.configureTableHeaderView(with: profile)
			self.configureTableCells(with: self.accounts)
			self.tableView.reloadData()
		}
	}
	
	func configureTableHeaderView(with profile: Profile) {
		let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good morning,",
													name: profile.firstName,
													date: Date())
		headerView.configure(viewModel: vm)
	}
	
	func configureTableCells(with accounts: [Account]) {
		accountCellViewModels = accounts.map {
			AccountSummaryCell.ViewModel(accountType: $0.type,
										 accountName: $0.name,
										 balance: $0.amount)
		}
	}
}
