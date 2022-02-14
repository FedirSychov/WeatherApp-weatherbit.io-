//
//  WeatherBitService.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 11.02.22.
//

import Foundation

enum OpenWeatherMapError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

class WeatherbitService {
  typealias WeatherDataCompletion = (WeatherbitData?, OpenWeatherMapError?) -> ()
  
  private static let apiKey = "95b90b41d14f4b548cf535bfef50196c"
  private static let host = "api.weatherbit.io"
  private static let path = "/v2.0/current"
  private static let fahrenheit = "I"
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd:HH"
    return formatter
  }()
  
  static func weatherDataForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
    var urlBuilder = URLComponents()
    urlBuilder.scheme = "https"
    urlBuilder.host = host
    urlBuilder.path = path
    urlBuilder.queryItems = [
      URLQueryItem(name: "key", value: apiKey),
      URLQueryItem(name: "units", value: fahrenheit),
      URLQueryItem(name: "lat", value: "\(latitude)"),
      URLQueryItem(name: "lon", value: "\(longitude)")
    ]
    
    let url = urlBuilder.url!
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      //execute completion handler on main thread
      DispatchQueue.main.async {
        guard error == nil else {
          print("Failed request from Weatherbit: \(error!.localizedDescription)")
          completion(nil, .failedRequest)
          return
        }
        
        guard let data = data else {
          print("No data returned from Weatherbit")
          completion(nil, .noData)
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          print("Unable to process Weatherbit response")
          completion(nil, .invalidResponse)
          return
        }
        
        guard response.statusCode == 200 else {
          print("Failure response from Weatherbit: \(response.statusCode)")
          completion(nil, .failedRequest)
          return
        }
        
        do {
          let decoder = JSONDecoder()
          let weatherData: WeatherbitData = try decoder.decode(WeatherbitData.self, from: data)
          completion(weatherData, nil)
        } catch {
          print("Unable to decode Weatherbit response: \(error.localizedDescription)")
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
}
