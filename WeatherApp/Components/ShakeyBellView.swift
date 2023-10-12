//
//  ShakeyBellView.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 12.10.2023.
//

import UIKit

final class ShakeyBellView: UIView {
	let imageView = UIImageView()
	
	let buttonView = UIButton()
	let bettonHeight: CGFloat = 16
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
		style()
		layout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		CGSize(width: 48, height: 48)
	}
}

// MARK: - Private methods

private extension ShakeyBellView {
	func setup() {
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_:)))
		imageView.addGestureRecognizer(singleTap)
		imageView.isUserInteractionEnabled = true
	}
	
	func style() {
		translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		let image = UIImage(systemName: "bell.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
		imageView.image = image
		
		buttonView.translatesAutoresizingMaskIntoConstraints = false
		buttonView.backgroundColor = .systemRed
		buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
		buttonView.layer.cornerRadius = bettonHeight / 2
		buttonView.setTitle("9", for: .normal)
		buttonView.setTitleColor(.white, for: .normal)
	}
	
	func layout() {
		addSubview(imageView)
		addSubview(buttonView)
		
		// ImageView
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 24),
			imageView.widthAnchor.constraint(equalToConstant: 24)
		])
		
		// Button
		NSLayoutConstraint.activate([
			buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
			buttonView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -9),
			buttonView.heightAnchor.constraint(equalToConstant: 16),
			buttonView.widthAnchor.constraint(equalToConstant: 16)
		])
	}
}

// MARK: Actions

private extension ShakeyBellView {
	@objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
		shakeWith(duration: 1, angle: .pi / 8, yOffset: 0.0)
	}
	
	func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
		let numberOfFrame: Double = 6
		let frameDuration = Double(1 / numberOfFrame)
		
		imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
		
		print("anchorPoint: \(imageView.layer.anchorPoint)")
		
		UIView.animateKeyframes(withDuration: duration, delay: 0) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: frameDuration,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: frameDuration * 2,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: frameDuration * 3,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: frameDuration * 4,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: frameDuration * 5,
							   relativeDuration: frameDuration) {
				self.imageView.transform = .identity
			}
		}
	}
}
