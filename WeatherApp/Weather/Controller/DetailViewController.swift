//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import UIKit

class DetailViewController: UIViewController {
//MARK: - IBOutlet
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
//MARK: - Public properties
    var cityName  = ""
    var visibility = ""
    var systemIconName = ""
    var weatherDiscription = ""
    var temperature = ""
    var feelsLike = ""
    var minTemp = ""
    var maxTemp = ""
    var pressure = ""
    var windSpeed = ""

//MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = cityName
        imageView.image =  UIImage(systemName: systemIconName)
        temperatureLabel.text = temperature
        feelsLikeLabel.text = feelsLike
        minTempLabel.text = minTemp
        maxTempLabel.text = maxTemp
        visibilityLabel.text = visibility
        pressureLabel.text = pressure
        windSpeedLabel.text = windSpeed
    }
    
//MARK: - Public methods
    func configure(with currentWeather: CurrentWeather) {
        cityName = currentWeather.cityName
        visibility  = currentWeather.visibilityString
        systemIconName = currentWeather.systemIconNameString
        weatherDiscription = currentWeather.weatherDescription
        temperature = currentWeather.temperatureString
        feelsLike = currentWeather.feelsLiketempString
        minTemp = currentWeather.tempMinString
        maxTemp = currentWeather.tempMaxString
        pressure = currentWeather.pressureLabel
        windSpeed = currentWeather.windSpeedString
    }
}


