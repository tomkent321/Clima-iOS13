
//
//  WeatherData.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    
    let count: Int
    let message: String
    let list: [List]
    
}

struct List: Codable {
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Weather: Codable {
    let id: Int
    
}
// list[0].main.temp
