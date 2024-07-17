//
//  WeatherEventModel.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 16.07.2024.
//

import Foundation

enum WeatherEvent: Int {
	case clear, rain, storm, fog, snowfall
}

struct WeatherEventModel: Identifiable {
	var id: WeatherEvent
	var title: String
	var icon: String
	var isSelected: Bool = false
}
