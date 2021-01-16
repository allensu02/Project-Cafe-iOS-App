//
//  Cafe.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/23.
//

import Foundation
import MapKit

class CafeResults: Codable {
    let results: [Cafe]
    let next: String?
    let count: Int?
}

class CafeOnMap: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var cafe: Cafe!
    var title: String?
    var locationName: String?
    //let discipline: String?
    init (cafe: Cafe) {
        self.cafe = cafe
        coordinate = CLLocationCoordinate2D(latitude: cafe.latitude, longitude: cafe.longitude)
        self.title = cafe.name
        self.locationName = cafe.address
        
        super.init()
    }

    
}
struct Cafe: Codable {
    let name: String
    let city: String
    let address: String
    let operatingHours: [OpeningHourPerDay]
    let url: String?
    let distance: Double
    let latitude: Double
    let longitude: Double
    let mrtStation: String
    let wifi: Bool
    let timeLimit: Bool
    let plugs: Bool
    let nearMrt: Bool
    let pourOver: Bool
    let singleOrigin: Bool?
    let desserts: Bool?
    let meals: Bool?
    let priceLevel: Int
    //check with backend to see why those are doubles in the json
    let seats: Int
    let quietness: Int
    let tastiness: Int
}

struct OpeningHourPerDay: Codable {
    let dayOfWeek: Int
    let startTime: String?
    let endTime: String?
}
