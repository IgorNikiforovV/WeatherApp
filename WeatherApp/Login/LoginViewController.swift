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
	let titleLabel = UILabel()
	let subtitleLabel = UILabel()
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
	
	// animation
	let leadingEdgeOnScreen: CGFloat = 16
	let leadingEdgeOffScreen: CGFloat = -1000
	
	private var titleLeadingAnchor: NSLayoutConstraint?
	private var subtitleLeadingAnchor: NSLayoutConstraint?

	override func viewDidLoad() {
		super.viewDidLoad()

		style()
		layout()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		animate()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		signInButton.configuration?.showsActivityIndicator = false
		loginView.cleanTextFields()
	}
}

private extension LoginViewController {
	func style() {
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.textAlignment = .center
		titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
		titleLabel.adjustsFontForContentSizeCategory = true
		titleLabel.text = "Weather"
		titleLabel.alpha = 0
		
		subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
		subtitleLabel.textAlignment = .center
		subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
		subtitleLabel.adjustsFontForContentSizeCategory = true
		subtitleLabel.numberOfLines = 0
		subtitleLabel.text = "Your premium source for all things banking!"
		subtitleLabel.alpha = 0
		
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
		view.addSubview(titleLabel)
		view.addSubview(subtitleLabel)
		view.addSubview(loginView)
		view.addSubview(signInButton)
		view.addSubview(errorMessageLabel)
		
		// Title
		NSLayoutConstraint.activate([
			subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
			titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
			
		])

		titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
		titleLeadingAnchor?.isActive = true
		
		// Subtitle
		NSLayoutConstraint.activate([
			loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
			subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
		subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
		subtitleLeadingAnchor?.isActive = true

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
	
	func animate() {
		let duration = 0.8

		let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
			self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
			self.view.layoutIfNeeded()
		}
		animator1.startAnimation()
		
		let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
			self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
			self.view.layoutIfNeeded()
		}
		animator2.startAnimation(afterDelay: 0.2)
		
		let animator3 = UIViewPropertyAnimator(duration: duration * 2, curve: .easeOut) {
			self.titleLabel.alpha = 1
			self.subtitleLabel.alpha = 1
		}
		animator3.startAnimation(afterDelay: 0.2)
	}
	
	func shakeButton() {
		let animation = CAKeyframeAnimation()
		animation.keyPath = "position.x"
		animation.values = [0, 10, -10, 10, 0]
		animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
		animation.duration = 0.4
		
		animation.isAdditive = true
		signInButton.layer.add(animation, forKey: "shake")
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
		shakeButton()
	}
}

