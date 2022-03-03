//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Андрей Бучевский on 04.02.2022.
//

import UIKit

class ListTableViewController: UITableViewController {
//MARK: - Private properties
    private var currentWeather: [CurrentWeather]!
    
//MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Погода"
        currentWeather = []
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }

    //MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentWeather.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let currentWeather = currentWeather[indexPath.row]
        cell.configure(with: currentWeather)
        return cell
    }
    
    //Jump to DetailViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let currentWeather = currentWeather[indexPath.row]
        vc.configure(with: currentWeather)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Functions
    //Add button function
    @objc func addButtonTapped() {
        self.presentSearchAlertConroller(withTitle: "Введите город", message: nil, style: .alert) { [weak self] city in
            guard let self = self else {return}
            CurrentWeatherNetworkService.getCurrentWeather(city: city) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.presentErrorAlertConroller(withTitle: "Something goes wrong", message: "\(error.localizedDescription)", style: .alert)
                    case .success(let currentWeather):
                        self.currentWeather.append(currentWeather)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
}
