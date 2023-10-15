//
//  AccountSummaryViewControllerTests.swift
//  WeatherUnitAppTests
//
//  Created by Игорь Никифоров on 15.10.2023.
//

import Foundation
import XCTest

@testable import WeatherApp

class AccountSummaryViewControllerTests: XCTestCase {
	var vc: AccountSummaryViewController!
	var mockManager: MockProfileManager!

	override func setUp() {
		super.setUp()
		
		vc = AccountSummaryViewController()
		vc.loadViewIfNeeded()
		mockManager = MockProfileManager()
		vc.profielManager = mockManager
	}
	
	func testTitleAndMessageForServerError() throws {
		let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
		XCTAssertEqual("Server Error", titleAndMessage.0)
		XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
	}
	
	func testTitleAndMessageForDecodingError() throws {
		let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
		XCTAssertEqual("Decoding Error", titleAndMessage.0)
		XCTAssertEqual("We could not precess your request. Please try again.", titleAndMessage.1)
	}
	
	func testAlertForServerError() {
		mockManager.error = .serverError
		vc.forceFetchProfile()

		XCTAssertEqual("Server Error", vc.errorAlert.title)
		XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
	}
		
	func testAlertForDecodingError() {
		mockManager.error = .decodingError
		vc.forceFetchProfile()

		XCTAssertEqual("Decoding Error", vc.errorAlert.title)
		XCTAssertEqual("We could not precess your request. Please try again.", vc.errorAlert.message)
	}
	
	func testFetchProfile() {
		vc.forceFetchProfile()

		XCTAssertEqual(mockManager.profile, vc.profile)
	}
}

// MARK: Mocks

extension AccountSummaryViewControllerTests {
	class MockProfileManager: ProfileManageable {
		var profile: Profile?
		var error: NetworkError?
		
		func fetchProfile(forUserId userId: String, completion: @escaping (Result<WeatherApp.Profile, WeatherApp.NetworkError>) -> Void) {
			if let error {
				completion(.failure(error))
				return
			}
			profile = Profile(id: "1", firstName: "firstName", lastName: "lastName")
			completion(.success(profile!))
		}
	}
}

extension Profile: Equatable {
	public static func == (lhs: Profile, rhs: Profile) -> Bool {
		lhs.id == rhs.id && lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
	}
}
