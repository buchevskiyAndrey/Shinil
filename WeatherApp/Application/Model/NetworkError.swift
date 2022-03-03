//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 02.03.2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
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

