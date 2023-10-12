//
//  AccountSummaryHeaderView.swift
//  WeatherApp
//
//  Created by Игорь Никифоров on 06.10.2023.
//

import UIKit

final class AccountSummaryHeaderView: UIView {
	
	@IBOutlet var contentView: UIView!
	
	let shakeyBellView = ShakeyBellView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialSetup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override var intrinsicContentSize: CGSize {
		CGSize(width: UIView.noIntrinsicMetric, height: 144)
	}
	
	private func initialSetup() {
		let bundle = Bundle(for: AccountSummaryHeaderView.self)
		bundle.loadNibNamed("AccountSummaryHeaderView", owner: self)
		addSubview(contentView)
		contentView.backgroundColor = appColor
		
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		
		setupShakeyBell()
	}
	
	private func setupShakeyBell() {
		shakeyBellView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(shakeyBellView)
		
		NSLayoutConstraint.activate([
			shakeyBellView.rightAnchor.constraint(equalTo: rightAnchor),
			shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor),
		])
	}
}
