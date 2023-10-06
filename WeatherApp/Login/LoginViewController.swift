//
//  ViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 03.10.2023.
//

import UIKit

protocol LogoutDelegate: AnyObject {
	func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
	func didLogin()
}

final class LoginViewController: UIViewController {
	let loginView = LoginView()
	let signInButton = UIButton(type: .system)
	let errorMessageLabel = UILabel()
	
	weak var delegate: LoginViewControllerDelegate?
	
	var username: String? {
		loginView.usernameTextField.text
	}
	
	var password: String? {
		loginView.passwordTextField.text
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		style()
		layout()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		signInButton.configuration?.showsActivityIndicator = false
		loginView.cleanTextFields()
	}
}

private extension LoginViewController {
	func style() {
		loginView.translatesAutoresizingMaskIntoConstraints = false
		
		signInButton.translatesAutoresizingMaskIntoConstraints = false
		signInButton.configuration = .filled()
		signInButton.configuration?.imagePadding = 8 // for indicator spacing
		signInButton.setTitle("Sign In", for: [])
		signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
		
		errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
		errorMessageLabel.textAlignment = .center
		errorMessageLabel.numberOfLines = 0
		errorMessageLabel.textColor = .systemRed
		errorMessageLabel.isHidden = true
	}

	func layout() {
		view.addSubview(loginView)
		view.addSubview(signInButton)
		view.addSubview(errorMessageLabel)

		// LoginView
		NSLayoutConstraint.activate([
			loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
		])
		
		// Button
		NSLayoutConstraint.activate([
			signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
			signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2)
		])

		// Label
		NSLayoutConstraint.activate([
			errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
			errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
			errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2)
		])
	}
}

// MARK: Actions

private extension LoginViewController {
	@objc
	func signInTapped() {
		errorMessageLabel.isHidden = true
		login()
	}
	
	func login() {
		guard let username, let password else {
			assertionFailure("Username / password should never be nil")
			return
		}
		
		if username.isEmpty || password.isEmpty {
			configureView(withMessage: "Username / password cannot be blank")
			return
		}
		
		if username == "John" && password == "Qwerty" {
			signInButton.configuration?.showsActivityIndicator = true
			delegate?.didLogin()
		} else {
			configureView(withMessage: "Incorrect username / password")
		}
	}
	
	func configureView(withMessage message: String) {
		errorMessageLabel.isHidden = false
		errorMessageLabel.text = message
	}
}

