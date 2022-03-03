//
//  AlertController.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import Foundation
import UIKit

extension ListTableViewController {
    func presentSearchAlertConroller(withTitle title: String, message: String?, style: UIAlertController.Style, completionHandler: @escaping (String) -> Void) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { textField in
            //The list of cities just to fill placeholder
            let cities = ["Нью-Йорк", "Лондон", "Москва", "Париж", "Токио"]
            textField.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Искать", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else {return}
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completionHandler(city)
            }
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
    
    func presentErrorAlertConroller(withTitle title: String, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}
