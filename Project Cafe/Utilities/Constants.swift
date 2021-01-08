//
//  Constants.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

struct CategoryList {
    let work = Category(type: .work, button: PCIconButton(iconImage: Icons.computerIcon, title: CategoryString.work.rawValue), presetFilters: [FilterString.noLimit.rawValue, FilterString.wifi.rawValue, FilterString.outlets.rawValue, FilterString.quiet.rawValue])
    let groupMeal = Category(type: .groupMeal, button: PCIconButton(iconImage: Icons.groupIcon, title: CategoryString.groupMeal.rawValue), presetFilters: [FilterString.mrt.rawValue])
    let drinkCoffee = Category(type: .drinkCoffee, button: PCIconButton(iconImage: Icons.coffeeIcon, title: CategoryString.drinkCoffee.rawValue), presetFilters: [FilterString.goodCoffee.rawValue])
    let relax = Category(type: .relax, button: PCIconButton(iconImage: Icons.relaxIcon, title: CategoryString.relax.rawValue), presetFilters: [FilterString.quiet.rawValue, FilterString.noLimit.rawValue])
}


struct FilterList {
    let noLimit = Filter(type: .noLimit, button: PCIconButton(iconImage: Icons.clockIcon, title: FilterString.noLimit.rawValue))
    let goodCoffee = Filter(type: .goodCoffee, button: PCIconButton(iconImage: Icons.coffeeIcon, title: FilterString.goodCoffee.rawValue))
    let outlets = Filter(type: .outlets, button: PCIconButton(iconImage: Icons.outletIcon, title: FilterString.outlets.rawValue))
    let wifi = Filter(type: .wifi, button: PCIconButton(iconImage: Icons.wifiIcon, title: FilterString.wifi.rawValue))
    let quiet = Filter(type: .quiet, button: PCIconButton(iconImage: Icons.quietIcon, title: FilterString.quiet.rawValue))
    let mrt = Filter(type: .mrt, button: PCIconButton(iconImage: Icons.mrtIcon, title: FilterString.mrt.rawValue))
    let price = Filter(type: .price, button: PCIconButton(iconImage: Icons.priceIcon, title: FilterString.price.rawValue))
    let openTime = Filter(type: .openTime, button: PCIconButton(iconImage: Icons.calendarIcon, title: FilterString.openTime.rawValue))
    let openNow = Filter(type: .openNow, button: PCIconButton(iconImage: Icons.storeIcon, title: FilterString.openNow.rawValue))
}
    


enum CategoryString: String, CaseIterable {
    case work = "專心工作"
    case relax = "悠閒放空"
    case groupMeal = "朋友聚餐"
    case drinkCoffee = "喝杯咖啡"
}


enum FilterString: String, CaseIterable{
    case noLimit = "不限時"
    case goodCoffee = "有手沖"
    case outlets = "有插座"
    case openNow = "營業中"
    case wifi = "有 Wi-Fi"
    case quiet = "安靜"
    case mrt = "捷運站近"
    case price = "價位"
    case openTime = "營業時間"
}

enum Icons {
    static let computerIcon = UIImage(systemName: "desktopcomputer")!
    static let relaxIcon = UIImage(systemName: "book")!
    static let groupIcon = UIImage(systemName: "person.2")!
    static let coffeeIcon = UIImage(named: "cupIcon")!
    static let outletIcon = UIImage(systemName: "battery.25")!
    static let clockIcon = UIImage(systemName: "clock")!
    static let storeIcon = UIImage(named: "storeIcon")!
    static let wifiIcon = UIImage(systemName: "wifi")!
    static let quietIcon = UIImage(systemName: "speaker.zzz")!
    static let mrtIcon = UIImage(systemName: "tram.fill")!
    static let priceIcon = UIImage(systemName: "dollarsign.circle")!
    static let calendarIcon = UIImage(systemName: "calendar")!
    static let minusIcon = UIImage(systemName: "minus.circle")!
}




enum Colors {
    static let defaultBrown = UIColor(red: 128/255, green: 54/255, blue: 2/255, alpha: 1)
    static let pcOrange = UIColor(red: 0.976, green: 0.506, blue: 0.259, alpha: 1)
}

enum Images {
    static let defaultLogo = UIImage(named: "javaLogo")!
    static let cafePlaceholderImage = UIImage(named: "cafePlaceholderImage")!
}


enum Fonts {
    static let merriweather = UIFont(name: "Merriweather-Regular", size: 25)
}

