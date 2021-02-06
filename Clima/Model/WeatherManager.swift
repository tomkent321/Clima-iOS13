//
//  WeatherManager.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

//protocol should be set up in the same file as the class it affects  see lesson 153
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/find?&

   
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String, units: String){
        var urlString = "\(weatherUrl)&units=\(units)&q=\(cityName)"
        urlString = urlString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        performRequest(with: urlString)
    }
    
    func fetchWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, units: String){
        let urlString = "\(weatherUrl)&units=\(units)&lat=\(lattitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {

        // 1. Create a URL
        if let url = URL(string: urlString) {

            // 2. Create a URLSession
            let session = URLSession(configuration: .default)

            // 3. Give the session a task...an annonymous function with a trailing closure see lesson 151
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    print(error!)
                    return
                }

                // see lesson 153 "self" must be added in an enclosure
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
            print(decodedData)
            if decodedData.count != 0 {
            let name = decodedData.list[0].name
            let id = decodedData.list[0].weather[0].id
            let temp = decodedData.list[0].main.temp
           
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                return weather
            } else {
                
                let name = "Not Found"
                let id = 781
                let temp = 0.0
               
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
                    return weather
            }
            
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}


