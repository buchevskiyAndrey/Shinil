//
//  CurrentWeatherNetworkService.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 02.03.2022.
//

import UIKit
import CoreLocation



class CurrentWeatherNetworkService {
    private init() {}
    
    static func getCurrentWeather(city: String, completion: @escaping(Result<CurrentWeather, Error>) -> Void) {
        getCoordinateFrom(city: city) { coordinate, error in
            guard let coordinate = coordinate else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidInput))
                }
                return
            }
            
            
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric&lang=ru"
            guard let url = URL(string: urlString)
            else {
                completion(.failure(NetworkError.badRequest))
                return
            }
            URLSession.shared.request1(url: url, expecting: CurrentWeatherData.self) { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let currentWeatherData):
                    guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                        completion(.failure(NetworkError.internalError))
                        return
                    }
                    completion(.success(currentWeather))
                }
            }
        }
    }
    
    private static func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
