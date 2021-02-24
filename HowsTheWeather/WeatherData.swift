//
//  WeatherData.swift
//  How'sTheWeather
//
//  Created by Elmira on 22.02.21.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
