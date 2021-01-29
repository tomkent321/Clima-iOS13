//
//  WeatherModel.swift
//  Clima
//
//  Created by Thomas Hurd on 1/26/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
//    var cityName: String {
//        return cityName.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
//    }
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%0.1f", temperature)
    }
    
    
    var conditionName: String {
        switch conditionId {
        case (200...299) :
            return "cloud.bolt"
        case (300...399) :
            return "cloud.drizzle"
        case (500...599) :
            return "cloud.heavyrain"
        case (600...699) :
            return "cloud.snow"
        case (711) :
            return "smoke"
        case (721) :
            return "sun.haze"
        case (731) :
            return "sun.dust"
        case (741) :
            return "cloud.fog"
        case (751...762) :
            return "sun.dust"
        case (781) :
            return "tornado"
        case (800) :
            return "sun.max"
        case (801...804) :
            return "cloud"
            
        default:
            return "sun.max"
            
    
        }
    }
    
}
    

