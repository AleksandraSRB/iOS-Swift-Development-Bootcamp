//
//  WeatherManager.swift
//  Clima
//
//  Created by Aleksandra Sobot on 29.3.22..
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let weatherManager = "https://api.openweathermap.org/data/2.5/weather?appid=196a82280d4d7b2d7224059421e51de4&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityname: String){
        let urlString = "\(weatherManager)&q=\(cityname)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherManager)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // copletion handler
    func performRequest(with urlString: String) {
        
        // 1. Create a URL
        if let url = URL (string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? " "){
            
            // 2. Create a URL session
            let urlSession = URLSession(configuration: .default)
            
            // 3. Give a URL session a taks
            let task = urlSession.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let lat = decodedData.coord.lat
            let lon = decodedData.coord.lon
            print(lat)
            print(lon)
            
            // ovde kreiramo novi weather objekat od WeatherModel strukture,
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
