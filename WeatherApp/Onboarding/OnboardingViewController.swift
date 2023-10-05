//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 05.10.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
	let stackView = UIStackView()
	let imageView = UIImageView()
	let label = UILabel()
	private let heroImageName: String
	private let titleText: String
	
	init(heroImageName: String, titleText: String) {
		self.heroImageName = heroImageName
		self.titleText = titleText

		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
		layout()
    }
}

// MARK: Private method

extension OnboardingViewController {
	func style() {
		// stackView
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 20
		
		// imageView
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(named: heroImageName)
		
		// label
		//label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		label.adjustsFontForContentSizeCategory = true
		label.numberOfLines = 0
		label.text = titleText
	}
	
	func layout() {
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(label)
		view.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
			view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1)
		])
	}
}
