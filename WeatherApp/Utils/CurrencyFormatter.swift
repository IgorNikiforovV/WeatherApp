//
//  CurrentFormatter.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 08.10.2023.
//

import UIKit

struct CurrencyFormatter {
//	func makeAttributedCurrency(_ balance: Decimal) -> NSAttributedString {
//		let intDollars = NSDecimalNumber(decimal: balance).intValue
//		let stringDollars = "\(intDollars)"
//		let stringCent = "\(balance - Decimal(intDollars))"
//
//		let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
//		let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
//		let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
//
//		let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
//		let dollarString = NSAttributedString(string: stringDollars, attributes: dollarAttributes)
//		let centString = NSAttributedString(string: stringCent, attributes: centAttributes)
//
//		rootString.append(dollarString)
//		rootString.append(centString)
//
//		return rootString
//	}
	
	func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
		let tuple = breakIntoDollarAndCents(amount)
		return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
	}
	
	// Convert 929466.23 > "929,466" and "23"
	func breakIntoDollarAndCents(_ amount: Decimal) -> (String, String) {
		let tuple = modf((amount.doubleValue))
		
		let dollars = convertDollar(tuple.0)
		let cents = convertCents(tuple.1)
		
		return (dollars, cents)
	}
	
	// 929466 > 929,466
	private func convertDollar(_ dollarPart: Double) -> String {
		let dollarsWithDecimal = dollarsFormatted(dollarPart) // "$929,466.00"
		let formatter = NumberFormatter()
		let decimalSeparator = formatter.decimalSeparator! // "."
		let dollarComponents = dollarsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
		var dollars = dollarComponents.first! // "$929,466"
		dollars.removeFirst() // "929,466"
		
		return dollars
	}
	
	// Convert 0.23 > 23
	private func convertCents(_ centPart: Double) -> String {
		centPart == 0 ? "00" : String(format: "%.0f", centPart * 100)
	}
	
	// Converts 929466 > $929,466.00
	func dollarsFormatted(_ dollars: Double) -> String {
		let formatter = NumberFormatter()
		formatter.locale = Locale(identifier: "en_US")
		
		formatter.numberStyle = .currency
		formatter.usesGroupingSeparator = true
		
		if let result = formatter.string(from: dollars as NSNumber) {
			return result
		}
		return ""
	}
	
	private func makeBalanceAttributed(dollars: String, cents: String) -> NSMutableAttributedString {
		let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
		let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
		let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
		
		let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
		let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
		let centString = NSAttributedString(string: cents, attributes: centAttributes)
		
		rootString.append(dollarString)
		rootString.append(centString)
		
		return rootString
	}
}
