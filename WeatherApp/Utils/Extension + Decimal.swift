//
//  Extension + Decimal.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 08.10.2023.
//

import Foundation

extension Decimal {
	var doubleValue: Double {
		NSDecimalNumber(decimal: self).doubleValue
	}
}
