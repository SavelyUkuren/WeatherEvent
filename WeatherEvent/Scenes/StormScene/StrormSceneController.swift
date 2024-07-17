//
//  StrormSceneController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 17.07.2024.
//

import GameplayKit
import SpriteKit

class StormSceneController: RainSceneController {
	
	override func setup() {
		super.setup()
		cloudSpeed = 0.0015
	}
	
	override func setupNoise() {
		sourceNoise.frequency = 2.5
		sourceNoise.octaveCount = 6
		sourceNoise.lacunarity = 2.8
		sourceNoise.persistence = 0.4
		
		background?.color = UIColor(red: 40 / 255,
									green: 50 / 255,
									blue: 70 / 255,
									alpha: 1)
		noiseGradientColors[-1] = background?.color
		noiseGradientColors[1] = UIColor(red: 210 / 255, green: 210 / 255, blue: 210 / 255, alpha: 1)
	}
	
	override func startAnimation() {
		super.startAnimation()
		emitterSpeed = -3000
		particleCount = 1200
	}
}
