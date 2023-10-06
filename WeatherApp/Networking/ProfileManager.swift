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
