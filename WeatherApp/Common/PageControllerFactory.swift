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
		let controller = UIViewController()
		switch page {
		case .first:
			controller.view.backgroundColor = .systemRed
		case .second:
			controller.view.backgroundColor = .systemGreen
		case .third:
			controller.view.backgroundColor = .systemBlue
		}
		return controller
	}
}
