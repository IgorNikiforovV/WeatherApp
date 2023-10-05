//
//  OnboardingContainerViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 05.10.2023.
//

import UIKit

final class OnboardingContainerViewController: UIViewController {
	let pageViewController: UIPageViewController
	var pages = [UIViewController]()
	var currentVC: UIViewController {
		didSet {
			
		}
	}
	
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
		
		view.backgroundColor = .systemPurple
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.didMove(toParent: self)
		
		pageViewController.dataSource = self
		pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: view.topAnchor),
			view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false)
	}
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		getPreviousViewController(from: viewController)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		getNextViewController(from: viewController)
	}
	
	private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else {
			return nil
		}
		
		currentVC = pages[index - 1]
		return currentVC
	}
	
	private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
		guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else {
			return nil
		}
		
		currentVC = pages[index + 1]
		return currentVC
	}
	
	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		pages.count
	}
	
	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		pages.firstIndex(of: self.currentVC) ?? 0
	}

	
	
	
}
