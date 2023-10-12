//
//  UITextField + SecureToggle.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 12.10.2023.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
	func enablePasswordToggle() {
		passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
		passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
		passwordToggleButton.addTarget(self, action: #selector(passwordViewTapped), for: .touchUpInside)
		rightView = passwordToggleButton
		rightViewMode = .always
	}

	// Action
	@objc func passwordViewTapped(_ sender: Any) {
		isSecureTextEntry.toggle()
		passwordToggleButton.isSelected.toggle()
	}
}
