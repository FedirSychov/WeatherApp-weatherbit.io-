//
//  APIData.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 27.11.21.
//

import Foundation

class WeatherData {
    public var cities: [Weather] = []
    
    init() {
        self.getWeather()
    }
    
    func getWeather() {
        API.getPost { (weatherr) in
            self.cities = weatherr
        }
    }
}
