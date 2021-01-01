//
//  Constants.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

enum Colors {
    static let defaultBrown = UIColor(red: 128/255, green: 54/255, blue: 2/255, alpha: 1)
    static let pcOrange = UIColor(red: 0.976, green: 0.506, blue: 0.259, alpha: 1)
}

enum Images {
    static let defaultLogo = UIImage(named: "javaLogo")!
    static let cafePlaceholderImage = UIImage(named: "cafePlaceholderImage")
}

enum Icons {
    static let computerIcon = UIImage(systemName: "desktopcomputer")!
    static let relaxIcon = UIImage(systemName: "book")!
    static let groupIcon = UIImage(systemName: "person.2")!
    static let coffeeIcon = UIImage(named: "cupIcon")!
    static let outletIcon = UIImage(systemName: "battery.25")!
    static let clockIcon = UIImage(systemName: "clock")!
    static let storeIcon = UIImage(named: "storeIcon")!
}

enum Fonts {
    static let merriweather = UIFont(name: "Merriweather-Regular", size: 25)
}

enum Category: String, CaseIterable {
    case work = "專心工作"
    case relax = "悠閒放空"
    case groupMeal = "朋友聚餐"
    case drinkCoffee = "喝杯咖啡"
}

enum Filter: String, CaseIterable {
    case noLimit = "不限時"
    case goodCoffee = "有手沖"
    case outlets = "有插座"
    case openNow = "營業中"
}
