//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import Foundation

//MARK: - CurrentWeather
struct CurrentWeatherData: Decodable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
    let name: String
}

//MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let description: String
}

//MARK: - Main
struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
    }
}

//MARK: - Wind
struct Wind: Decodable {
    let speed: Double
}


