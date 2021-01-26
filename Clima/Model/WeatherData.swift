
//
//  WeatherData.swift
//  Clima
//
//  Created by Thomas Hurd on 1/25/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let count: Int
    let message: String
    let list: [List]
    
}


struct List: Decodable {
    let name: String
    let main: Main
    let wind: Wind
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

// list[0].main.temp
