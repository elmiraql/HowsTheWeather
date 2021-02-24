//
//  NetWorkViewController.swift
//  How'sTheWeather
//
//  Created by Elmira on 21.02.21.
//

import Foundation
import CoreLocation

protocol NetWorkViewControllerDelegate {
    func didUpdateWeather(_ netWork: NetWorkViewController, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class NetWorkViewController {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=cc543ee64695ffda6459c511dcdb3221&units=metric"
    var delegate: NetWorkViewControllerDelegate?
    
    func fetchWeather (city: String) {
       let urlString = "\(weatherUrl)&q=\(city)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(lat: CLLocationDegrees, lon: CLLocationDegrees){
        let urlString = "\(weatherUrl)&lat=\(lat)&lon=\(lon)"
        performRequest(urlString: urlString)
    }
    
    func performRequest (urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJson(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJson (weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
         let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weather = WeatherModel(name: name, id: id, temperature: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
