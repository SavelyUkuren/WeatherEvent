//
//  StrormSceneController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 17.07.2024.
//

import GameplayKit
import SpriteKit

class StormSceneController: RainSceneController {
	
	var lightningArea: SKSpriteNode?
	var lightning: SKSpriteNode?
	
	private var lightningTimer: Timer?
	
	override func setup() {
		super.setup()
		cloudSpeed = 0.0015
		clouds?.zPosition = 3
		lightning?.zPosition = 2
		
		setupLighting()
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
		noiseGradientColors[-1] = .clear
		noiseGradientColors[1] = UIColor(red: 210 / 255, green: 210 / 255, blue: 210 / 255, alpha: 1)
	}
	
	override func startAnimation() {
		super.startAnimation()
		emitterSpeed = -3000
		particleCount = 1200
		
		lightningTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
			let rX = CGFloat.random(in: self.lightningArea!.position.x...self.lightningArea!.size.width)
			let rY = CGFloat.random(in: self.lightningArea!.position.y...self.lightningArea!.size.height)
			
			
			self.lightning?.alpha = 0
			self.lightning?.position = CGPoint(x: rX, y: rY)
			
			let animation = SKAction.sequence([
				SKAction.fadeAlpha(to: 1, duration: 0.1),
				SKAction.fadeAlpha(to: 0, duration: 0.1)
			])
			self.lightning?.run(animation)
			
		}
		lightningTimer?.fire()
	}
	
	override func stopAnimation() {
		super.stopAnimation()
		lightningTimer?.invalidate()
		lightningTimer = nil
	}
	
	func setupLighting() {
		lightningArea = childNode(withName: "lightningArea") as? SKSpriteNode
		lightning = childNode(withName: "lightning") as? SKSpriteNode
	}
}
