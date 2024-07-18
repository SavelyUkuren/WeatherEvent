//
//  WeatherEventCollectionViewCell.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 16.07.2024.
//

import UIKit

class WeatherEventCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var secondContentView: UIView!
	@IBOutlet weak var imageView: UIImageView!
	
	override var isSelected: Bool {
		didSet {
			if isSelected {
				selectCell()
			} else {
				deselectCell()
			}
		}
	}
	
	var weatherEvent: WeatherEventModel? {
		didSet {
			if let unwrappedEvent = weatherEvent {
				titleLabel.text = unwrappedEvent.title
				imageView.image = UIImage(systemName: unwrappedEvent.icon)
			}
		}
	}
	
	func selectCell() {
		secondContentView.backgroundColor = .systemBlue
		titleLabel.textColor = .white
		imageView.tintColor = .white
	}
	
	func deselectCell() {
		secondContentView.backgroundColor = .white
		titleLabel.textColor = .label
		imageView.tintColor = .systemBlue
	}
	
}
