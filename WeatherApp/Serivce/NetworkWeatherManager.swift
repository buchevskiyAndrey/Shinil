//
//  CurrentWeatherRequest.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import Foundation
import CoreLocation
import UIKit

protocol NetworkWeatherManagerProtocol: AnyObject {
    func fetchCurrentWeather(forCity city: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void)
}

class NetworkWeatherManager: NetworkWeatherManagerProtocol {
//MARK: - Public methods
    func fetchCurrentWeather(forCity city: String, completion: @escaping (Result<CurrentWeather, Error>) -> Void) {
        getCoordinateFrom(city: city) { (coordinate, error) in
            guard let coordinate = coordinate
            else {
                //force unwrap чекнуть
                completion(.failure(error!))
                return
            }
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(apiKey)&units=metric&lang=ru"
            guard let url = URL(string: urlString)
            else {
                completion(.failure(NetworkWeatherManagerError.badRequest))
                return
                
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let data = data {
                    let currentWeatherData = self.parseJSON(forData: data)
                    switch currentWeatherData {
                    case .failure(let error):
                        completion(.failure(error))
                    case .success(let currentWeatherData):
                        guard let currentWeatherData = currentWeatherData else {
                            completion(.failure(NetworkWeatherManagerError.internalError))
                            return
                        }
                        guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData)
                        else {
                            completion(.failure(NetworkWeatherManagerError.internalError))
                            return
                        }
                        completion(.success(currentWeather))
//                        self.delegate?.addCity(self, with: currentWeather)
                        print(currentWeather.temperature)
                    }
                } else {
                    completion(.failure(NetworkWeatherManagerError.invalidInput))
                }
            }
            task.resume()
        }
    }
    
    fileprivate func parseJSON(forData data: Data) -> Result<CurrentWeatherData?, Error> {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            return .success(currentWeatherData)
        } catch {
            return .failure(NetworkWeatherManagerError.internalError)
        }
    }
    
    fileprivate func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
//MARK: - Extensions
//Error handling
extension NetworkWeatherManager {
    enum NetworkWeatherManagerError: Error, LocalizedError {
        case badRequest
        case internalError
        case invalidInput
        
        var errorDescription: String? {
            switch self {
            case .badRequest:
                return NSLocalizedString("Проверьте Ваше интернет-соединение", comment: "Poor connection")
            case .internalError:
                return NSLocalizedString("Приложение сломано :(", comment: "My error")
            case .invalidInput:
                return NSLocalizedString("Сервер не нашел информации по данной локации", comment: "API's problem")
            }
        }
    }
}
