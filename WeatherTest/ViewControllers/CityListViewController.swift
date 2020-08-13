//
//  CityListViewController.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import UIKit

class CityListViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = .zero
        tableView.tableFooterView = UIView()
        return tableView
    }()

    var cities: [Forecast] = [] {
        didSet {
            selectedCityIndex = nil
            tableView.reloadData()
        }
    }
    
    var selectedCityIndex: IndexPath!
    
    let cellId = "cityCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.frame = self.view.frame
        
        self.view.addSubview(tableView)
//        tableView.fillSuperview()
        
    }

    override func viewDidLayoutSubviews() {
        tableView.frame = self.view.frame
    }

}


extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CityTableViewCell
        cell.forecast = cities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedCityIndex == indexPath {
            return 120
        }
        return 53
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedCityIndex == indexPath {
            selectedCityIndex = nil
        } else {
            selectedCityIndex = indexPath
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}

