//
//  NetworkManager.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?"
    private init () {}

    func getWeather(city: String, completed: @escaping (Cafe) -> Void) {
        let endpoint = baseURL + "q=\(city)&appid=\(APIKeys.openWeatherKey)&units=metric"
        guard let url = URL(string: endpoint) else {
            print("error with url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                print("hey")
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let cafeObj = try? decoder.decode(Cafe.self, from: data) else {
                    print("error occured")
                    return
                }
                completed(cafeObj)
            }
        }.resume()
        print("finsihed")
    }
    
}
