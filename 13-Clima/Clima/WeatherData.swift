//
//  WeatherData.swift
//  Clima
//
//  Created by Aleksandra Sobot on 30.3.22..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord

    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}

struct Coord: Codable {
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
}
