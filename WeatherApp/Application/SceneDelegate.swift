//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 03.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	let loginViewController = LoginViewController()
	let onboardingContainerViewController = OnboardingContainerViewController()
	let dummyViewController = DummyViewController()

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(windowScene: windowScene)
		// window?.rootViewController = LoginViewController()
		window?.backgroundColor = .systemBackground
		
		window?.rootViewController = loginViewController
		
		loginViewController.delegate = self
		onboardingContainerViewController.delegate = self
		dummyViewController.logoutDelegate = self
		
		window?.makeKeyAndVisible()
	}
}

extension SceneDelegate: LoginViewControllerDelegate {
	func didLogin() {
		if LocalState.hasOnboarding {
			setRootViewController(dummyViewController)
		} else {
			setRootViewController(onboardingContainerViewController)
		}
	}
}

extension SceneDelegate: OnboardingContainerViewControllerDelegate {
	func didFinishOnboarding() {
		LocalState.hasOnboarding = true
		setRootViewController(dummyViewController)
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


