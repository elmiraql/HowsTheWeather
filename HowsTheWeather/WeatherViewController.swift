//
//  ViewController.swift
//  How'sTheWeather
//
//  Created by Elmira on 21.02.21.
//

import UIKit   
import CoreLocation


class WeatherViewController: UIViewController {
    
    var netWorkViewController = NetWorkViewController()
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        searchTextField.delegate = self
        netWorkViewController.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

//MARK: EXTENSIONS

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = searchTextField.text {
            netWorkViewController.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Type something..."
//            return false
//        }
//    }
}

extension WeatherViewController: NetWorkViewControllerDelegate {
    func didUpdateWeather(_ netWork: NetWorkViewController, weather: WeatherModel) { //the first thing that by convention, we always have in a delegate method is the identity of the object that caused this delegate method.
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString
            self.weatherImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.name
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {//And this is an array of CLLocations. We can get hold of the last location that they added in there.
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            netWorkViewController.fetchWeather(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
