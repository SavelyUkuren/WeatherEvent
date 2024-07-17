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
			}
		}
	}
	
	func selectCell() {
		secondContentView.backgroundColor = .systemBlue
		titleLabel.textColor = .white
	}
	
	func deselectCell() {
		secondContentView.backgroundColor = .white
		titleLabel.textColor = .label
	}
	
}
