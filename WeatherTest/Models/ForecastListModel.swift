//
//  ForecastListModel.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import Foundation

struct ForecastList: Decodable {
    let count: Int?
    let list: [Forecast]?
}
