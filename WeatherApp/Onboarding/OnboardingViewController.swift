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

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
		layout()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
//		imageView.heightAnchor.constraint(equalToConstant: view.bounds.width - 20).isActive = true
//		imageView.widthAnchor.constraint(equalToConstant: view.bounds.width / 2).isActive = true
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
		imageView.image = UIImage(named: "mountain")
		
		// label
		//label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .title3)
		label.adjustsFontForContentSizeCategory = true
		label.numberOfLines = 0
		label.text = "Car is faster, easer to use, and has a brand new look and feel that will make you feel like you are back in 1989 "

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
