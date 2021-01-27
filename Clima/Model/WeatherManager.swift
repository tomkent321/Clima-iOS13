//
//  WeatherManager.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherUrl = 

    
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
            let id = decodedData.list[0].weather[0].id
            print("id: \(id)")
            let symbol = getConditionName(weatherId: id)
            print(symbol)
        } catch {
            print("did not work")
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        
        switch weatherId {
        case (200...299) :
            return "cloud.bolt.fill"
        case (300...399) :
            return "cloud.drizzle.fill"
        case (500...599) :
            return "cloud.heavyrain.fill"
        case (600...699) :
            return "cloud.snow.fill"
        case (711) :
            return "smoke.fill"
        case (721) :
            return "sun.haze.fill"
        case (731) :
            return "sun.dust.fill"
        case (741) :
            return "cloud.fog.fill"
        case (751...762) :
            return "sun.dust.fill"
        case (781) :
            return "tornado"
        case (800...804) :
            return "cloud.fill"
            
        default:
            return "sun.max.fill"
            
    
        }
        
    }
}
