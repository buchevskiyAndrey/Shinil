//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import UIKit

class ListTableViewController: UITableViewController {
//MARK: - Private properties
    private var currentWeatherManager: NetworkWeatherManagerProtocol!
    private var currentWeather: [CurrentWeather]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Погода"
        currentWeatherManager = NetworkWeatherManager()
        currentWeather = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
//        currentWeatherManager.fetchCurrentWeather(forCity: "London")
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.cityLabel.text = currentWeather[indexPath.row].cityName
        cell.weatherLabel.text = currentWeather[indexPath.row].weatherDescription
        cell.temperatureLabel.text = currentWeather[indexPath.row].temperatureString
        return cell
    }
    
    //Jump to DetailViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        vc.cityName = self.currentWeather[indexPath.row].cityName
        vc.visibility  = self.currentWeather[indexPath.row].visibilityString
        vc.systemIconName = self.currentWeather[indexPath.row].systemIconNameString
        vc.weatherDiscription = self.currentWeather[indexPath.row].weatherDescription
        vc.temperature = self.currentWeather[indexPath.row].temperatureString
        vc.feelsLike = self.currentWeather[indexPath.row].feelsLiketempString
        vc.minTemp = self.currentWeather[indexPath.row].tempMinString
        vc.maxTemp = self.currentWeather[indexPath.row].tempMaxString
        vc.pressure = self.currentWeather[indexPath.row].pressureLabel
        vc.windSpeed = self.currentWeather[indexPath.row].windSpeedString
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Functions
    //Add button function
    @objc func addButtonTapped() {
        self.presentSearchAlertConroller(withTitle: "Введите город", message: nil, style: .alert) { city in
            self.currentWeatherManager.fetchCurrentWeather(forCity: city) { [unowned self ] result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.presentErrorAlertConroller(withTitle: "Something goes wrong", message:"\(error.localizedDescription)", style: .alert)
                        //МБ здесь создавать объект каррентвезер
                    case .success(let currentWeather):
                        self.currentWeather.append(currentWeather)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
