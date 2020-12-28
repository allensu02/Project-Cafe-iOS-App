//
//  Cafe.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/23.
//

import Foundation

struct Cafe: Codable {
    let name: String
    let coord: Coordinate
    let main: Main
    let weather: [Weather]
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
