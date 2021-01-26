//
//  WeatherManager.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/find?&appid=54595804fe3fd9df922ec095689a886b"
    
    func fetchWeather(cityName: String, units: String){
        let urlString = "\(weatherUrl)&units=\(units)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        
        // 1. Create a URL
        if let url = URL(string: urlString) {
            
        // 2. Create a URLSession
        let session = URLSession(configuration: .default)
        
        // 3. Give the session a task
        let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
        
        // 4. Start the task
        task.resume()
            
    }
     
}
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            print(error)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
        
    }
    
}
