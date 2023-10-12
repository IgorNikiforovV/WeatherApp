//
//  LoginView.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 03.10.2023.
//

import UIKit

final class LoginView: UIView {

	let stackView = UIStackView()
	let usernameTextField = UITextField()
	let passwordTextField = UITextField()
	let deviderView = UIView()

	// MARK: - life cycle
	override init(frame: CGRect) {
		super.init(frame: frame)

		style()
		layout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: private extension
private extension LoginView {
	func style() {
		translatesAutoresizingMaskIntoConstraints = false
		backgroundColor = .secondarySystemBackground
		layer.cornerRadius = 5
		clipsToBounds = true
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 8
		
		usernameTextField.translatesAutoresizingMaskIntoConstraints = false
		usernameTextField.placeholder = "Username"
		usernameTextField.delegate = self

		passwordTextField.translatesAutoresizingMaskIntoConstraints = false
		passwordTextField.placeholder = "Password"
		passwordTextField.isSecureTextEntry = true
		passwordTextField.enablePasswordToggle()
		passwordTextField.delegate = self
		
		deviderView.translatesAutoresizingMaskIntoConstraints = false
		deviderView.backgroundColor = .secondarySystemFill
	}
	
	func layout() {
		stackView.addArrangedSubview(usernameTextField)
		stackView.addArrangedSubview(deviderView)
		stackView.addArrangedSubview(passwordTextField)
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
			trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
			bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
		])
		
		deviderView.heightAnchor.constraint(equalToConstant: 1).isActive = true
	}
}

// MARK: Public methods

extension LoginView {
	public func cleanTextFields() {
		usernameTextField.text = ""
		passwordTextField.text = ""
	}
}


// MARK: UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		usernameTextField.endEditing(true)
		return true
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
	}
}

 

