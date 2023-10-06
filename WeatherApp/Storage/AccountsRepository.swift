//
//  AccountsRepository.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 08.10.2023.
//

protocol IAccountsRepository {
	func fetchAccounts() -> [AccountSummaryCell.ViewModel]
}

struct AccountsRepository: IAccountsRepository {
	func fetchAccounts() -> [AccountSummaryCell.ViewModel] {
		[
			AccountSummaryCell.ViewModel(accountType: .banking,
										 accountName: "Basic Saving",
										 balance: 929466.23),
			AccountSummaryCell.ViewModel(accountType: .banking,
										 accountName: "No-Fee All-In",
										 balance: 17562.44),
			AccountSummaryCell.ViewModel(accountType: .creditCard,
										 accountName: "Visa Avion Card",
										 balance: 412.83),
			AccountSummaryCell.ViewModel(accountType: .creditCard,
										 accountName: "Student Mastercard",
										 balance: 50.83),
			AccountSummaryCell.ViewModel(accountType: .investment,
										 accountName: "Tax-Free Saver",
										 balance: 2000.00),
			AccountSummaryCell.ViewModel(accountType: .investment,
										 accountName: "Growth Fund",
										 balance: 15000.00),
		]
	}
}
