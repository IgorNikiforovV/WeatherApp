//
//  Extension + Date.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 13.10.2023.
//

import Foundation

extension Date {
	static var weatherDateFormatter: DateFormatter {
		let formatter = DateFormatter()
		formatter.timeZone = TimeZone(abbreviation: "MDT")
		return formatter
	}
	
	var monthDayYearString: String {
		let dateFormatter = Date.weatherDateFormatter
		dateFormatter.dateFormat = "MMM d, yyyy"
		return dateFormatter.string(from: self)
	}
}
