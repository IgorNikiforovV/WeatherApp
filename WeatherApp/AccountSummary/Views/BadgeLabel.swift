//
//  BadgeLabel.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 12.10.2023.
//

import UIKit

final class BadgeLabel: UIView {
	@IBOutlet var contentView: UIView!
	@IBOutlet var buttonView: UIView!
	@IBOutlet var imageView: UIImageView!
	
	let buttonHeight: CGFloat = 16
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		let bundle = Bundle(for: BadgeLabel.self)
		bundle.loadNibNamed(String(describing: BadgeLabel.self), owner: self)
		addSubview(contentView)
		
		setup()
	}
}

// MARK: - Setup

private extension BadgeLabel {
	func setup() {
		buttonView.layer.cornerRadius = buttonHeight / 2
		
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(_: )))
		imageView.addGestureRecognizer(singleTap)
		imageView.isUserInteractionEnabled = true
	}
}

// MARK: - Actions
private extension BadgeLabel {
	@objc func imageViewTapped(_ recognizer: UITapGestureRecognizer) {
		shakeWith(duration: 1.0, angle: .pi/8, yOffset: 0.0)
	}
	
	func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
		print("duration: \(duration), angle: \(angle), yOffset: \(yOffset)")
		
		let numberOfFrames: Double = 6
		let frameDuration = Double(1 / numberOfFrames)
		
		//imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
		
		print("anchorPoint: \(imageView.layer.anchorPoint)")
		
		UIView.animateKeyframes(withDuration: duration, delay: 0) {
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration) {
				self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration * 2) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration * 3) {
				self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration * 4) {
				self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
			}
			
			UIView.addKeyframe(withRelativeStartTime: 0.0,
							   relativeDuration: frameDuration * 5) {
				self.imageView.transform = .identity
			}
		}
	}
}
