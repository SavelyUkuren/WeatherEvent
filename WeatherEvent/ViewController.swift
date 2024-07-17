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
    
	@IBOutlet weak var freqLabel: UILabel!
	@IBOutlet weak var octLabel: UILabel!
	@IBOutlet weak var lacunLabel: UILabel!
	@IBOutlet weak var persisLabel: UILabel!
	
	var events: [WeatherEventModel] = []
	var selectedEvent: IndexPath = IndexPath(row: 0, section: 0)
	
	var scene: WeatherScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
		setupEvents()
        setupWeatherEventCollectionView()
        setupScene()
    }

    private func setupWeatherEventCollectionView() {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: 128, height: 60)
		layout.scrollDirection = .horizontal
		
		weatherEventsCollectionView.showsHorizontalScrollIndicator = false
		weatherEventsCollectionView.collectionViewLayout = layout
        weatherEventsCollectionView.delegate = self
        weatherEventsCollectionView.dataSource = self
        
    }
    
    private func setupScene() {
        if let scene = WeatherScene(fileNamed: "Scene.sks") {
			self.scene = scene
			
			scene.drawEvent(.clear)
            skSceneView.presentScene(scene)
        }
    }
	
	private func setupEvents() {
		events.append(WeatherEventModel(id: .clear, title: "Clear", icon: "sun.max"))
		events.append(WeatherEventModel(id: .rain, title: "Rain", icon: "cloud.rain"))
		events.append(WeatherEventModel(id: .storm, title: "Storm", icon: "cloud.bolt.rain"))
		events.append(WeatherEventModel(id: .fog, title: "Fog", icon: "cloud.fog"))
	}
	
	@IBAction func freqSliderChanged(_ sender: UISlider) {
		scene?.sourceNoise.frequency = Double(sender.value)
		freqLabel.text = "Freq \(sender.value)"
	}
	
	@IBAction func octSliderChanged(_ sender: UISlider) {
		scene?.sourceNoise.octaveCount = Int(sender.value)
		octLabel.text = "Oct \(sender.value)"
	}
	
	
	@IBAction func lacunSliderChanged(_ sender: UISlider) {
		scene?.sourceNoise.lacunarity = Double(sender.value)
		lacunLabel.text = "Lacun \(sender.value)"
	}
	
	
	@IBAction func persisSliderChanged(_ sender: UISlider) {
		scene?.sourceNoise.persistence = Double(sender.value)
		persisLabel.text = "Persis \(sender.value)"
	}
	
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherEventCollectionViewCell
        
		cell.weatherEvent = events[indexPath.row]
        
		if indexPath == selectedEvent {
			cell.selectCell()
		}
		
        return cell
    }
    
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		(collectionView.cellForItem(at: selectedEvent) as? WeatherEventCollectionViewCell)?.deselectCell()
		selectedEvent = indexPath
		(collectionView.cellForItem(at: indexPath) as? WeatherEventCollectionViewCell)?.selectCell()
		
		if let scene = scene {
			scene.drawEvent(events[indexPath.row].id)
		}
	}
    
	
}
