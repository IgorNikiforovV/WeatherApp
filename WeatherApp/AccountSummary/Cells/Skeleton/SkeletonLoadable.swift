//
//  SkeletonLoadable.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 14.10.2023.
//

import UIKit

protocol SkeletonLoadable {}

extension SkeletonLoadable {
	func makeAnimationGroup(previousGroup: CAAnimationGroup? = nil) -> CAAnimationGroup {
		let animDuratiuon: CFTimeInterval = 1.5

		let anim1 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
		anim1.fromValue = UIColor.gradientLightGray.cgColor
		anim1.toValue = UIColor.gradientDarkGray.cgColor
		anim1.duration = animDuratiuon
		anim1.beginTime = 0.0
		
		let anim2 = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.backgroundColor))
		anim2.fromValue = UIColor.gradientDarkGray.cgColor
		anim2.toValue = UIColor.gradientLightGray.cgColor
		anim2.duration = animDuratiuon
		anim2.beginTime = anim1.beginTime + anim1.duration
		
		let group = CAAnimationGroup()
		group.animations = [anim1, anim2]
		group.repeatCount = .greatestFiniteMagnitude
		group.duration = anim2.beginTime + anim2.duration
		group.isRemovedOnCompletion = false
		
		if let previousGroup {
			// Offset groups by 0.33 second for effect
			group.beginTime = previousGroup.beginTime + 0.33
		}
		
		return group
	}
}
