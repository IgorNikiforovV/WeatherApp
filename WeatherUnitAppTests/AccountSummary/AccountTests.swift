//
//  AccountTests.swift
//  WeatherUnitAppTests
//
//  Created by Игорь Никифоров on 13.10.2023.
//

import Foundation
import XCTest

@testable import WeatherApp

class AccountTests: XCTestCase {
	override func setUp() {
		super.setUp()
	}
	
	func testCanParse() {
		let json = """
		[
		  {
			"id": "1",
			"type": "Banking",
			"name": "Basic Savings",
			"amount": 929466.23,
			"createdDateTime" : "2010-06-21T15:29:32Z"
		  },
		  {
			"id": "2",
			"type": "Banking",
			"name": "No-Fee All-In Chequing",
			"amount": 17562.44,
			"createdDateTime" : "2011-06-21T15:29:32Z"
		  }
		]
		"""
		let data = json.data(using: .utf8)!
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		let accounts = try! decoder.decode([Account].self, from: data)
		
		print(accounts.map { $0.createdDateTime })
		
		XCTAssertEqual(accounts.count, 2)
		XCTAssertEqual(["1", "2"], accounts.map { $0.id })
		XCTAssertEqual([AccountType.banking, AccountType.banking], accounts.map { $0.type })
		XCTAssertEqual(["Basic Savings", "No-Fee All-In Chequing"], accounts.map { $0.name })
		XCTAssertEqual([929466.23, 17562.44], accounts.map { $0.amount })
		XCTAssertEqual(["июня 21, 2010", "июня 21, 2011"], accounts.map { $0.createdDateTime.monthDayYearString })
		
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		let firstDate = dateFormatter.date(from: "2010-06-21T15:29:32Z")!
		let secondDate = dateFormatter.date(from: "2011-06-21T15:29:32Z")!
		XCTAssertEqual([firstDate, secondDate], accounts.map { $0.createdDateTime })
	}
}
