//
//  WeatherScene.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 16.07.2024.
//

import SpriteKit
import GameplayKit

class WeatherScene: SKScene {
	
    private var background: SKSpriteNode?
	private var gradient: SKSpriteNode?
	private var rainEmitter: SKEmitterNode?
    
    private var clouds: SKSpriteNode?
	private var sun: SKSpriteNode?
    private var cloudNoiseXPos: Double = 0
	private var cloudSpeed: CGFloat = 0.0009
	
	private var currentEvent: WeatherEvent = .clear
	
	var sourceNoise = GKBillowNoiseSource()
	private var noiseGradientColors: [NSNumber: UIColor] = [-1: .black, 1: .white]
    
    override func sceneDidLoad() {
        setup()
    }
	
	override func update(_ currentTime: TimeInterval) {
	
	}
	
	func drawEvent(_ event: WeatherEvent) {
		currentEvent = event
		noiseGradientColors.removeAll()
		
		switch event {
		case .clear:
			sourceNoise.frequency = 3
			sourceNoise.octaveCount = 6
			sourceNoise.lacunarity = 2.8
			sourceNoise.persistence = 0.5
			
			background?.color = UIColor(red: 135 / 255,
										green: 206 / 255,
										blue: 235 / 255,
										alpha: 1)
			noiseGradientColors[-1] = background?.color
			noiseGradientColors[1] = .white
			
			rainIntensivity(0)
			hideSun(false)
			cloudSpeed = 0.0009
			sun?.zPosition = 10
		case .rain:
			sourceNoise.frequency = 2.3
			sourceNoise.octaveCount = 6
			sourceNoise.lacunarity = 2.7
			sourceNoise.persistence = 0.4

			background?.color = UIColor(red: 70 / 255,
										green: 80 / 255,
										blue: 100 / 255,
										alpha: 1)
			noiseGradientColors[-1] = background?.color
			noiseGradientColors[1] = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1)
			
			rainIntensivity(700, speed: -2000)
			hideSun(true)
			cloudSpeed = 0.0009
			break
		case .storm:
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
			
			rainIntensivity(1000, speed: -3000)
			hideSun(true)
			cloudSpeed = 0.002
			
			break
		case .fog:
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
			
			rainIntensivity(0)
			hideSun(false)
			cloudSpeed = 0.0004
			sun?.zPosition = 4
			break
		}
		
		gradient?.texture = createGradientTexture(size: gradient!.size,
												  startColor: .clear,
												  endColor: background!.color)
		
	}
    
    private func setup() {
        background = childNode(withName: "background") as? SKSpriteNode
		gradient = childNode(withName: "gradient") as? SKSpriteNode
		rainEmitter = childNode(withName: "rainEmmiter") as? SKEmitterNode
		
		sun = childNode(withName: "sun") as? SKSpriteNode
		sun?.position = CGPoint(x: -size.width / 5, y: size.height / 6)
		
		clouds = SKSpriteNode(texture: createCloudTexture(size: CGSize(width: size.width, height: size.height)))
		clouds!.size = CGSize(width: size.width, height: size.height)
		clouds?.position = CGPoint(x: 0, y: 0)
		clouds?.zPosition = 3
		clouds?.lightingBitMask = 1
		
		sourceNoise.seed = 666
		
        addChild(clouds!)
		
		let timer = Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { _ in
			self.updateWeather()
		}
		timer.fire()
    }
    
	private func createCloudTexture(size: CGSize,
									move: vector_double3? = nil) -> SKTexture {
		
        let noise = GKNoise(sourceNoise)
		noise.gradientColors = noiseGradientColors
		if move != nil { noise.move(by: move!) }
        
        let noiseMap = GKNoiseMap(noise)
        return SKTexture(noiseMap: noiseMap)
    }
	
	func createGradientTexture(size: CGSize, startColor: UIColor, endColor: UIColor) -> SKTexture? {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = CGRect(origin: .zero, size: size)
		gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		gradientLayer.locations = [0.0, 0.5]
		
		UIGraphicsBeginImageContext(size)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		gradientLayer.render(in: context)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let gradientImage = image else { return nil }
		return SKTexture(image: gradientImage)
	}
	
	private func rainIntensivity(_ raindropCount: CGFloat, speed: CGFloat? = nil) {
		rainEmitter?.particleBirthRate = raindropCount
		if speed != nil { rainEmitter?.particleSpeed = speed! }
	}
	
	private func hideSun(_ visible: Bool) {
		sun?.isHidden = visible
	}
	
	private func updateWeather() {
		updateClouds()
	}
	
	private func updateClouds() {
		cloudNoiseXPos += cloudSpeed
		let texture = createCloudTexture(size: CGSize(width: size.width, height: size.height),
										 move: vector_double3(cloudNoiseXPos, 0, 0))
		clouds?.texture = texture
	}
    
}
