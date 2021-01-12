//
//  FilterString.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/3.
//

import Foundation

enum Filter: String, CaseIterable{
    case noLimit = "不限時"
    case goodCoffee = "有手沖"
    case outlets = "有插座"
    case openNow = "營業中"
    case wifi = "有 Wi-Fi"
    case quiet = "安靜"
    case mrt = "捷運站近"
    case price = "價位"
    case openTime = "營業時間"
    case seats = "通常有位"
    case desserts = "提供甜點"
    case meals = "提供鹹食"
    
}
