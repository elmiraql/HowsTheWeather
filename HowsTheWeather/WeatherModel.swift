//
//  WeatherModel.swift
//  How'sTheWeather
//
//  Created by Elmira on 22.02.21.
//

import Foundation


struct WeatherModel {
    let name: String
    let id: Int
    let temperature: Double
    
    var tempString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.sun.fill"
        default:
            return "cloud"
        }
    }
}
