//
//  ClearSceneController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 17.07.2024.
//

import SpriteKit
import GameplayKit

class ClearSceneController: SKScene, WeatherSceneControllerProtocol {
	
	var background: SKSpriteNode?
	var gradient: SKSpriteNode?
	
	var sun: SKSpriteNode?
	var clouds: SKSpriteNode?
	
	var sourceNoise = GKBillowNoiseSource()
	var noiseGradientColors: [NSNumber: UIColor] = [-1: .black, 1: .white]
	
	private(set) var cloudNoiseXPos: Double = 0
	var cloudSpeed: CGFloat = 0.0009
	
	var timer: Timer?
	
	override func sceneDidLoad() {
		super.sceneDidLoad()
		setup()
	}
	
	func setup() {
		background = childNode(withName: "background") as? SKSpriteNode
		gradient = childNode(withName: "gradient") as? SKSpriteNode
		
		sun = childNode(withName: "sun") as? SKSpriteNode
		sun?.position = CGPoint(x: -size.width / 5, y: size.height / 6)
		
		setupNoise()
		
		clouds = SKSpriteNode(texture: createCloudTexture(size: CGSize(width: size.width, height: size.height)))
		clouds?.size = CGSize(width: size.width, height: size.height)
		clouds?.position = CGPoint(x: 0, y: 0)
		clouds?.zPosition = 3
		addChild(clouds!)
		
		gradient?.texture = createGradientTexture(size: gradient!.size, startColor: .clear, endColor: background!.color)
		
	}
	
	func setupNoise() {
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
	}
	
	func startAnimation() {
		timer = Timer.scheduledTimer(withTimeInterval: 0.033, repeats: true) { _ in
			self.updateWeather()
		}
		
		timer?.fire()
	}
	
	func stopAnimation() {
		timer?.invalidate()
		timer = nil
	}
	
	func createCloudTexture(size: CGSize,
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
		gradientLayer.locations = [0.0, 0.6]
		
		UIGraphicsBeginImageContext(size)
		guard let context = UIGraphicsGetCurrentContext() else { return nil }
		gradientLayer.render(in: context)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		guard let gradientImage = image else { return nil }
		return SKTexture(image: gradientImage)
	}
	
	func updateWeather() {
		updateClouds()
	}
	
	func updateClouds() {
		cloudNoiseXPos += cloudSpeed
		let texture = createCloudTexture(size: CGSize(width: size.width, height: size.height),
										 move: vector_double3(cloudNoiseXPos, 0, 0))
		clouds?.texture = texture
	}
}
