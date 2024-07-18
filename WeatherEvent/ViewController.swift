//
//  ViewController.swift
//  WeatherEvent
//
//  Created by Савелий Никулин on 16.07.2024.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherEventsCollectionView: UICollectionView!
    @IBOutlet weak var skSceneView: SKView!
	
	var events: [WeatherEventModel] = []
	var selectedEventIndex: IndexPath = IndexPath(row: 0, section: 0)
	
	var scenes: [WeatherEvent: WeatherSceneControllerProtocol] = [:]
	var selectedScene: WeatherSceneControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		setupEvents()
        setupWeatherEventCollectionView()
        setupScene()
		setRandomScene()
    }

    private func setupWeatherEventCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 128, height: 60)
		layout.scrollDirection = .horizontal
		
		weatherEventsCollectionView.showsHorizontalScrollIndicator = false
		weatherEventsCollectionView.collectionViewLayout = layout
        weatherEventsCollectionView.delegate = self
        weatherEventsCollectionView.dataSource = self
		weatherEventsCollectionView.allowsSelection = true
        
    }
    
    private func setupScene() {
		let clearScene = ClearSceneController(fileNamed: "ClearScene.sks")
		let rainScene = RainSceneController(fileNamed: "RainScene.sks")
		let stormScene = StormSceneController(fileNamed: "StormScene.sks")
		let fogScene = FogSceneController(fileNamed: "FogScene.sks")
		let snowfallScene = SnowfallSceneController(fileNamed: "SnowfallScene.sks")
		
		scenes[.clear] = clearScene
		scenes[.rain] = rainScene
		scenes[.storm] = stormScene
		scenes[.fog] = fogScene
		scenes[.snowfall] = snowfallScene
		
    }
	
	private func setupEvents() {
		events.append(WeatherEventModel(id: .clear, title: "Clear", icon: "sun.max"))
		events.append(WeatherEventModel(id: .rain, title: "Rain", icon: "cloud.rain"))
		events.append(WeatherEventModel(id: .storm, title: "Storm", icon: "cloud.bolt.rain"))
		events.append(WeatherEventModel(id: .fog, title: "Fog", icon: "cloud.fog"))
		events.append(WeatherEventModel(id: .snowfall, title: "Snowfall", icon: "cloud.snow"))
	}
	
	private func selectScene(id: WeatherEvent) {
		
		selectedScene?.stopAnimation()
		selectedScene = scenes[id]
		selectedScene?.startAnimation()
		
		if let scene = selectedScene {
			skSceneView.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
		}
	}
	
	private func setRandomScene() {
		if let event = events.randomElement() {
			let index = events.firstIndex { $0.id == event.id }!
			events[index].isSelected = true
			selectedEventIndex.row = index
			
			selectScene(id: event.id)
		}
	}
	
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherEventCollectionViewCell
        
		cell.weatherEvent = events[indexPath.row]
		
        return cell
    }
    
	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		events[indexPath.row].isSelected = false
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedEventIndex = indexPath
		events[selectedEventIndex.row].isSelected = true
		selectScene(id: events[indexPath.row].id)
	}
    
	
}
