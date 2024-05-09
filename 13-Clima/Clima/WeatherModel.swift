//
//  WeatherModel.swift
//  Clima
//
//  Created by Aleksandra Sobot on 30.3.22..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
  
    var temperatureString: String {
        return String (format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.rain"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
    
}
