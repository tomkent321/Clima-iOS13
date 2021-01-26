//
//  WeatherManager.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/find?&"
    
    func fetchWeather(cityName: String, units: String){
        let urlString = "\(weatherUrl)&units=\(units)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task...an annonymous function with a trailing closure see lesson 151
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                    print(safeData)
                }
            }
            
            // 4. Start the task
            task.resume()
            
        }
        
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.list[0].name)
            print("temp: \(decodedData.list[0].main.temp)")
            print("humidity: \(decodedData.list[0].main.humidity)")
            print("wind speed: \(decodedData.list[0].wind.speed)")
            print("wind direction: \(decodedData.list[0].wind.deg) degrees")
        } catch {
            print(error)
        }
    }
}
