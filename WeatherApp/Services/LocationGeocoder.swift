//
//  LocationGeocoder.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 11.02.22.
//

import Foundation
import CoreLocation

class LocationGeocoder {
  private lazy var geocoder = CLGeocoder()
  
    //Convert place name to Location
  func geocode(addressString: String, callback: @escaping ([Location]) -> ()) {
    geocoder.geocodeAddressString(addressString) { (placemarks, error) in
      var locations: [Location] = []
      if let error = error {
        print("Geocoding error: (\(error))")
      } else {
        if let placemarks = placemarks {
          locations = placemarks.compactMap { (placemark) -> Location? in
            guard
              let name = placemark.locality,
              let location = placemark.location
              else {
                return nil
            }
            let region = placemark.administrativeArea ?? ""
            let fullName = "\(name), \(region)"
            return Location(
              name: fullName,
              latitude: location.coordinate.latitude,
              longitude: location.coordinate.longitude)
          }
        }
      }
      callback(locations)
    }
  }
}
