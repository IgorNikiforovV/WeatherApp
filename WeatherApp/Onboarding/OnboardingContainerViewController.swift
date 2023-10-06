//
//  OnboardingContainerViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 05.10.2023.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
	func didFinishOnboarding()
}

final class OnboardingContainerViewController: UIViewController {
	let pageViewController: UIPageViewController
	var pages = [UIViewController]()
	var currentVC: UIViewController {
		didSet {
			guard let index = pages.firstIndex(of: currentVC) else { return }
			nextButton.isHidden = index == pages.count - 1
			backButton.isHidden = index == 0
			doneButton.isHidden = index != pages.count - 1
		}
	}
	
	let closeButton = UIButton(type: .system)
	let nextButton = UIButton(type: .system)
	let backButton = UIButton(type: .system)
	let doneButton = UIButton(type: .system)
	
	weak var delegate: OnboardingContainerViewControllerDelegate?
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
		
		let factory = PageControllerFactory()
		pages.append(contentsOf: [factory.controller(for: .first), factory.controller(for: .second), factory.controller(for: .third)])
		
		currentVC = pages.first!
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		currentVC = pages.first!

		setup()
		style()
		layout()
	}
	
	private func setup() {
		view.backgroundColor = .systemGray2
		
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.didMove(toParent: self)
		
		pageViewController.dataSource = self
		pageViewController.delegate = self
		pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: view.topAnchor),
			view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
	}

	private func style() {
		closeButton.translatesAutoresizingMaskIntoConstraints = false
		closeButton.setTitle("Close", for: [])
		closeButton.addTarget(self, action: #selector(closeTapped), for: .primaryActionTriggered)
		
		nextButton.translatesAutoresizingMaskIntoConstraints = false
		nextButton.setTitle("Next", for: [])
		nextButton.addTarget(self, action: #selector(nextTapped), for: .primaryActionTriggered)
		
		backButton.translatesAutoresizingMaskIntoConstraints = false
		backButton.setTitle("Back", for: [])
		backButton.addTarget(self, action: #selector(backTapped), for: .primaryActionTriggered)
		
		doneButton.translatesAutoresizingMaskIntoConstraints = false
		doneButton.setTitle("Done", for: [])
		doneButton.addTarget(self, action: #selector(doneTapped), for: .primaryActionTriggered)

		view.addSubview(closeButton)
		view.addSubview(nextButton)
		view.addSubview(backButton)
		view.addSubview(doneButton)
	}
	
	private func layout() {
		// Close
		NSLayoutConstraint.activate([
			closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
			closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 3),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
			backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 3),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 3),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
		])
	}
}

extension OnboardingContainerViewController: UIPageViewControllerDelegate {
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		if completed, let viewController = pageViewController.viewControllers?.first {
			currentVC = viewController
		}
	}
}

// MARK: UIPageViewControllerDataSource

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		return getPreviousViewController(from: viewController)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		return getNextViewController(from: viewController)
	}

	private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {
			return nil
		}

		//currentVC = pages[index - 1]
		return pages[index - 1]
	}
	
	private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
			return nil
		}

		return pages[index + 1]
	}
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		pages.count
	}
}

// MARK: - Actions
private extension OnboardingContainerViewController {
	@objc private func closeTapped() {
		delegate?.didFinishOnboarding()
	}
	
	@objc private func nextTapped() {
		guard let nextVC = getNextViewController(from: currentVC) else { return }
		
		pageViewController.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] _ in
			self?.currentVC = nextVC
		}
	}
	
	@objc private func backTapped() {
		guard let previousVC = getPreviousViewController(from: currentVC) else { return }
		
		pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true) { [weak self] _ in
			self?.currentVC = previousVC
		}
	}
	
	@objc private func doneTapped() {
		delegate?.didFinishOnboarding()
	}
}
