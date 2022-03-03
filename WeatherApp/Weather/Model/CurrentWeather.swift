//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let visibility: Int
    
    var visibilityString: String {
        return String(visibility)  + " м"
    }
    //MARK: - Weather description
    let code: Int
    let weatherDescription: String
    
    var systemIconNameString: String {
        switch code {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800:       return "sun.max.fill"
        case 801...804: return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    //MARK: - Main
    let temperature, feelsLiketemp, tempMin, tempMax: Double
    
    var temperatureString: String {
        String(format: "%0.0f", temperature) + "\u{00B0}C"
    }
    
    var feelsLiketempString: String {
        "Чувствуется как " +  String(format: "%0.0f", feelsLiketemp) + "\u{00B0}C"
    }
    
    var tempMinString: String {
        String(format: "%0.0f", tempMin) + "\u{00B0}C"
    }
    
    var tempMaxString: String {
        String(format: "%0.0f", tempMax) + "\u{00B0}C"
    }
    
    let pressure: Int
    var pressureLabel: String {
        String(pressure) + " мм."
    }
    
    //MARK: - Wind
    let windSpeed: Double
    var windSpeedString: String {
        return String(format: "%0.0f", windSpeed)  + " м/с"
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        visibility = currentWeatherData.visibility
        
        code = currentWeatherData.weather.first!.id
        weatherDescription = currentWeatherData.weather.first!.description
        
        temperature = currentWeatherData.main.temp
        feelsLiketemp = currentWeatherData.main.feelsLike
        tempMin = currentWeatherData.main.tempMin
        tempMax = currentWeatherData.main.tempMax
        pressure = currentWeatherData.main.pressure
        
        windSpeed = currentWeatherData.wind.speed
    }
}
