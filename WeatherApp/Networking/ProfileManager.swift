//
//  ProfileManageable.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 07.10.2023.
//

import Foundation

protocol ProfileManageable {
	func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void)
}

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

final class ProfileManmager: ProfileManageable {
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
