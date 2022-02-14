//
//  APIHelper.swift
//  WeatherApp
//
//  Created by Fedor Sychev on 27.11.21.
//

import Foundation

struct Weather: Decodable {
    var city: String
    var otherInfo: String
}

class API {
    
    public static func getPost(completion: @escaping ([Weather]) -> ()) {
        guard let url = URL(string: "asdchgoaiwuegcohasd") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            
            let weather = try! JSONDecoder().decode([Weather].self, from: data)
            
            DispatchQueue.main.async {
                completion(weather)
            }
        }
        .resume()
    }
    
}
