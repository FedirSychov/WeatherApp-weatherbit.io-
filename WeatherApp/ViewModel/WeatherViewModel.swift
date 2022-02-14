//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 11.02.22.
//

import Foundation
import UIKit.UIImage

public class WeatherViewModel {
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  
  private static let defaultAddress = "Augsburg"
  private let geocoder = LocationGeocoder()
  var locationName = Box("Loading...")
  let date = Box(" ")
  let icon: Box<UIImage?> = Box(nil)  //no image initially
  let summary = Box(" ")
  let forecastSummary = Box(" ")
  
  init() {
    changeLocation(to: Self.defaultAddress)
  }
  
  func changeLocation(to newLocation: String) {
    locationName.value = "Loading..."
    geocoder.geocode(addressString: newLocation) { [weak self] locations in
      guard let self = self else { return }
      if let location = locations.first {
        self.locationName.value = location.name
        self.fetchWeatherForLocation(location)
        return
      }
      self.locationName.value = "Not found"
      self.date.value = ""
      self.icon.value = nil
      self.summary.value = ""
      self.forecastSummary.value = ""
    }
  }
  
  private func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(
    latitude: location.latitude,
    longitude: location.longitude) { [weak self] (weatherData, error) in
      guard
        let self = self,
        let weatherData = weatherData
        else {
          return
        }
      self.date.value = self.dateFormatter.string(from: weatherData.date)
      self.icon.value = UIImage(named: weatherData.iconName)
      let temp = self.tempFormatter
        .string(from: weatherData.currentTemp as NSNumber) ?? ""
      self.summary.value = "\(weatherData.description) - \(temp)℉"
      self.forecastSummary.value = "\nSummary: \(weatherData.description)"
    }
  }
}
