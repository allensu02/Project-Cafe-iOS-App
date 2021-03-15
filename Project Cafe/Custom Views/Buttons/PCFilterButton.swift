//
//  PCFilterButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/8.
//

import UIKit

class PCFilterButton: PCIconButton {
    
    var filter: Filter?
    init(iconImage: UIImage, filter: Filter) {
        super.init(iconImage: iconImage, title: filter.rawValue)
        self.filter = filter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addColor() {
        super.addColor()
        
        switch filter {
        case .desserts:
            self.iconView.image = Icons.cakeFill
            break
        case .goodCoffee:
            self.iconView.image = Icons.cupFill
        case .meals:
            self.iconView.image = Icons.mealFill
        case .mrt:
            self.iconView.image = Icons.mrtFill
            break
        case .noLimit:
            self.iconView.image = Icons.clockFill
        case .openNow:
            self.iconView.image = Icons.storeFill
        case .openTime:
            self.iconView.image = Icons.calendarFill
            break
        case .outlets:
            self.iconView.image = Icons.plugFill
        case .price:
            self.iconView.image = Icons.moneyFill
        case .quiet:
            self.iconView.image = Icons.soundFill
            break
        case .seats:
            self.iconView.image = Icons.chairFill
        case .wifi:
            self.iconView.image = Icons.wifiFill
        default:
            return
        }
    }
    
    override func removeColor() {
        super.removeColor()
        switch filter {
        case .desserts:
            self.iconView.image = Icons.cakeOutline
            break
        case .goodCoffee:
            self.iconView.image = Icons.cupOutline
        case .meals:
            self.iconView.image = Icons.mealOutline
        case .mrt:
            self.iconView.image = Icons.mrtOutline
            break
        case .noLimit:
            self.iconView.image = Icons.clockOutline
        case .openNow:
            self.iconView.image = Icons.storeOutline
        case .openTime:
            self.iconView.image = Icons.calendarOutline
            break
        case .outlets:
            self.iconView.image = Icons.plugOutline
        case .price:
            self.iconView.image = Icons.moneyOutline
        case .quiet:
            self.iconView.image = Icons.soundOutline
            break
        case .seats:
            self.iconView.image = Icons.chairOutline
        case .wifi:
            self.iconView.image = Icons.wifiOutline
        default:
            return
        }
    }
    
    
}
