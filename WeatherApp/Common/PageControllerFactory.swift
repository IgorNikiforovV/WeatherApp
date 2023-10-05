//
//  PageControllerFactory.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 05.10.2023.
//

import UIKit

enum Page {
	case first
	case second
	case third
}

struct PageControllerFactory {
	func controller(for page: Page) -> UIViewController {
		switch page {
		case .first:
			return OnboardingViewController(heroImageName: "bird", titleText: "Car is faster, easer to use, and has a brand new look and feel that will make you feel like you are back in 1989.")
		case .second:
			return OnboardingViewController(heroImageName: "cake", titleText: "Move your money around the world quickly and securely.")
		case .third:
			return OnboardingViewController(heroImageName: "mountain", titleText: "Learn more at ru.wikipedia.org.")
		}
	}
}
