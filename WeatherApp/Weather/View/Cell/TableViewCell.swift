//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(with currentWeather: CurrentWeather) {
        cityLabel.text = currentWeather.cityName
        weatherLabel.text = currentWeather.weatherDescription
        temperatureLabel.text = currentWeather.temperatureString
    }
}
