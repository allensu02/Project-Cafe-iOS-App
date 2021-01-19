//
//  NetworkManager.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/23.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://project-cafe-api-staging.herokuapp.com/api/search/?"
    private init () {}

    func getCafes(lat: Double, lon: Double, limit: Int, completed: @escaping (CafeResults) -> Void) {
        let endpoint = baseURL + "latitude=\(lat)&longitude=\(lon)&limit=\(limit)"
        guard let url = URL(string: endpoint) else {
            print("error with url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let cafeObj = try? decoder.decode(CafeResults.self, from: data) else {
                    print("error hereee")
                    return
                }
                completed(cafeObj)
            }
        }.resume()
    }
    
}
