//
//  ForecastModel.swift
//  WeatherTest
//
//  Created by Eugeniy on 13.08.2020.
//  Copyright © 2020 Eugeniy. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let coord: Coordinates?
    let weather: [Weather]?
    let main: Main?
    let name: String?
}

struct Weather: Decodable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Decodable {
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double?
    let humidity: Double?
}

struct Coordinates: Decodable {
    let lat: Double?
    let lon: Double?
    let lng: Double?
}
