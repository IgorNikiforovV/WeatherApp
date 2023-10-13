//
//  AccountSummaryViewController + Networking.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 13.10.2023.
//

import Foundation

enum NetworkError: Error {
	case serverError
	case decodingError
}

struct Profile: Codable {
	let id: String
	let firstName: String
	let lastName: String
	
	enum CodingKeys: String, CodingKey {
		case id
		case firstName = "first_name"
		case lastName = "last_name"
	}
}

internal extension AccountSummaryViewController {
	func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
		let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			DispatchQueue.main.async {
				guard let data, error == nil else {
					return completion(.failure(.serverError))
				}
				
				do {
					let profile = try JSONDecoder().decode(Profile.self, from: data)
					print(profile)
					completion(.success(profile))
				} catch {
					print("\(error.localizedDescription)")
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}

struct Account: Codable {
	let id: String
	let type: AccountType
	let name: String
	let amount: Decimal
	let createdDateTime: Date
}

extension AccountSummaryViewController {
	func fetchAccounts(forUserId userId: String, completion: @escaping (Result<[Account], NetworkError>) -> Void) {
		let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)/accounts")!
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			DispatchQueue.main.async {
				guard let data, error == nil else {
					return completion(.failure(.serverError))
				}
				
				do {
					let decoder = JSONDecoder()
					decoder.dateDecodingStrategy = .iso8601
					
					let accounts = try decoder.decode([Account].self, from: data)
					completion(.success(accounts))
				} catch {
					print(error)
					completion(.failure(.decodingError))
				}
			}
		}.resume()
	}
}