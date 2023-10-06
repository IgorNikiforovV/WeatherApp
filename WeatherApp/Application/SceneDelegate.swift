//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 03.10.2023.
//

import UIKit

let appColor: UIColor = .systemTeal

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	let loginViewController = LoginViewController()
	let onboardingContainerViewController = OnboardingContainerViewController()
	let mainViewController = MainViewController()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		loginViewController.delegate = self
		onboardingContainerViewController.delegate = self
		
		window = UIWindow(windowScene: windowScene)
		window?.backgroundColor = .systemBackground
		
		let viewController = MainViewController()
		viewController.setStatusBar()
		
		UINavigationBar.appearance().isTranslucent = false
		UINavigationBar.appearance().backgroundColor = appColor
		
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}
}

extension SceneDelegate: LoginViewControllerDelegate {
	func didLogin() {
		if LocalState.hasOnboarding {
			setRootViewController(mainViewController)
		} else {
			setRootViewController(onboardingContainerViewController)
		}
	}
}

extension SceneDelegate: OnboardingContainerViewControllerDelegate {
	func didFinishOnboarding() {
		LocalState.hasOnboarding = true
		setRootViewController(mainViewController)
	}
}

extension SceneDelegate: LogoutDelegate {
	func didLogout() {
		setRootViewController(loginViewController)
	}
}

extension SceneDelegate {
	func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
		guard animated, let window else {
			self.window?.rootViewController = vc
			self.window?.makeKeyAndVisible()
			return
		}
		
		window.rootViewController = vc
		window.makeKeyAndVisible()
		UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
	}
}


