//
//  LocalState.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 06.10.2023.
//

import Foundation

final class LocalState {
	private enum Keys: String {
		case hasOnboarding
	}

	public static var hasOnboarding: Bool {
		get {
			UserDefaults.standard.bool(forKey: Keys.hasOnboarding.rawValue)
		}
		set {
			UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarding.rawValue)
			UserDefaults.standard.synchronize()
		}
	}
}
