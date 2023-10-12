//
//  AccountSummaryCell.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 07.10.2023.
//

import UIKit

final class AccountSummaryCell: UITableViewCell {
	
	enum AccountType: String {
		case banking
		case creditCard
		case investment
	}
	
	struct ViewModel {
		let accountType: AccountType
		let accountName: String
		let balance: Decimal //?
		
		var balanceAsAttributedString: NSAttributedString {
			CurrencyFormatter().makeAttributedCurrency(balance)
		}
	}
	
	let viewModel: ViewModel? = nil
	
	let typeLabel = UILabel()
	let underlineView = UIView(frame: .zero)
	let nameLabel = UILabel()
	
	let balanceStackView = UIStackView()
	let balanceLabel = UILabel()
	let balanceAmountLabel = UILabel()
	let chevronImageView = UIImageView()
	
	static let reuseIdentifier = "AccountSummaryCell"
	static let rowHeight: CGFloat = 102
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setup()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension AccountSummaryCell {
	func setup() {
		typeLabel.translatesAutoresizingMaskIntoConstraints  = false
		typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
		typeLabel.adjustsFontForContentSizeCategory = true
		typeLabel.text = "Account type"
		
		underlineView.translatesAutoresizingMaskIntoConstraints  = false
		underlineView.backgroundColor = appColor
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
		nameLabel.adjustsFontForContentSizeCategory = true
		nameLabel.adjustsFontSizeToFitWidth = true
		nameLabel.text = "Account name"
		
		balanceStackView.translatesAutoresizingMaskIntoConstraints = false
		balanceStackView.axis = .vertical
		balanceStackView.spacing = 0
		
		balanceLabel.translatesAutoresizingMaskIntoConstraints = false
		balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
		balanceLabel.textAlignment = .right
		balanceLabel.adjustsFontSizeToFitWidth = true
		balanceLabel.text = "Some balance"
		
		balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
		balanceAmountLabel.textAlignment = .right
		balanceAmountLabel.attributedText = makeFormattedBalance(dollars: "929,466", cent: "63")
		
		chevronImageView.translatesAutoresizingMaskIntoConstraints = false
		let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(appColor, renderingMode: .alwaysOriginal)
		chevronImageView.image = chevronImage

		contentView.addSubview(typeLabel) // important! add to contentView
		contentView.addSubview(underlineView)
		contentView.addSubview(nameLabel)
		balanceStackView.addArrangedSubview(balanceLabel)
		balanceStackView.addArrangedSubview(balanceAmountLabel)
		contentView.addSubview(balanceStackView)
		contentView.addSubview(chevronImageView)
	}

	func layout() {
		NSLayoutConstraint.activate([
			typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: contentView.topAnchor, multiplier: 2),
			typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2)
		])

		NSLayoutConstraint.activate([
			underlineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
			underlineView.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2),
			underlineView.heightAnchor.constraint(equalToConstant: 4),
			underlineView.widthAnchor.constraint(equalToConstant: 60)
		])
		
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.bottomAnchor, multiplier: 2),
			nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: contentView.leadingAnchor, multiplier: 2)
		])
		
		NSLayoutConstraint.activate([
			balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underlineView.topAnchor, multiplier: 0),
			balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
			contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
		])
		
		NSLayoutConstraint.activate([
			chevronImageView.centerYAnchor.constraint(equalTo: balanceStackView.centerYAnchor),
			contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
		])
	}
}

// MARK: private methods

private extension AccountSummaryCell {
	func makeFormattedBalance(dollars: String, cent: String) -> NSMutableAttributedString {
		let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
		let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
		let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
		
		let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
		let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
		let centString = NSAttributedString(string: cent, attributes: centAttributes)

		rootString.append(dollarString)
		rootString.append(centString)
		
		return rootString
	}
}

extension AccountSummaryCell {
	func configure(with vm: ViewModel) {
		typeLabel.text = vm.accountType.rawValue
		nameLabel.text = vm.accountName
		balanceAmountLabel.attributedText = vm.balanceAsAttributedString
		
		switch vm.accountType {
		case .banking:
			underlineView.backgroundColor = appColor
			balanceLabel.text = "Current balance"
		case .creditCard:
			underlineView.backgroundColor = .systemOrange
			balanceLabel.text = "Balance"
		case .investment:
			underlineView.backgroundColor = .systemPurple
			balanceLabel.text = "Value"
		}
	}
}
