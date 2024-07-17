//
//  FogSceneController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 17.07.2024.
//

import SpriteKit

class FogSceneController: ClearSceneController {
	
	override func setup() {
		super.setup()
		cloudSpeed = 0.0004
	}
	
	override func setupNoise() {
		super.setupNoise()
		sourceNoise.frequency = 3
		sourceNoise.octaveCount = 6
		sourceNoise.lacunarity = 2.8
		sourceNoise.persistence = 0.5
		
		background?.color = UIColor(red: 190 / 255,
									green: 210 / 255,
									blue: 240 / 255,
									alpha: 1)
		noiseGradientColors[-1] = background?.color
		noiseGradientColors[1] = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
		
	}
	
	override func startAnimation() {
		super.startAnimation()
		
	}
	
	override func stopAnimation() {
		super.stopAnimation()
		
	}
	
}
