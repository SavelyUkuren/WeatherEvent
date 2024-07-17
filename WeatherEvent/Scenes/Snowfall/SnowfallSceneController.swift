//
//  ScnowfallSceneController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 17.07.2024.
//

import SpriteKit

class SnowfallSceneController: RainSceneController {
	
	override func setup() {
		super.setup()
		emitter = childNode(withName: "snowEmitter") as? SKEmitterNode
	}
	
	override func setupNoise() {
		super.setupNoise()
		
		sourceNoise.frequency = 2
		sourceNoise.octaveCount = 6
		sourceNoise.lacunarity = 2.8
		sourceNoise.persistence = 0.4
		
		background?.color = UIColor(red: 100 / 255,
									green: 100 / 255,
									blue: 100 / 255,
									alpha: 1)
		noiseGradientColors[-1] = background?.color
		noiseGradientColors[1] = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)
	}
	
	override func startAnimation() {
		super.startAnimation()
		emitterSpeed = -400
		particleCount = 400
	}
	
	override func stopAnimation() {
		super.stopAnimation()
		emitterSpeed = 0
		particleCount = 0
	}
	
}
