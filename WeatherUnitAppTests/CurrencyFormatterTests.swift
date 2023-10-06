//
//  CurrencyFormatterTests.swift
//  WeatherUnitAppTests
//
//  Created by Игорь Никифоров on 10.10.2023.
//

import Foundation
import XCTest

@testable import WeatherApp

class Test: XCTestCase {
	var currencyFormatter: CurrencyFormatter!

	override func setUp() {
		super.setUp()
		
		currencyFormatter = CurrencyFormatter()
	}
	
	func testBreakDollarsIntoCents() throws {
		let result = currencyFormatter.breakIntoDollarAndCents(929486.23)
		XCTAssertEqual(result.0, "929,486")
		XCTAssertEqual(result.1, "23")
	}
	
	func testDollarsFormatted() throws {
		let result = currencyFormatter.dollarsFormatted(929486.23)
		XCTAssertEqual(result, "$929,486.23")
	}
	
	func testZeroDollarsFormatted() {
		let locale = Locale.current
		let currencySymbol = locale.currencySymbol!
		
		let result = currencyFormatter.dollarsFormatted(0)
		XCTAssertEqual(result, "\(currencySymbol)0.00")
	}
}
