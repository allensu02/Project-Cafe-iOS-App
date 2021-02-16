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
            self.iconView.image = Icons.dessertOutlined
            break
        case .goodCoffee:
            self.iconView.image = Icons.cupOutlined
        default:
            return
        }
    }
    
    override func removeColor() {
        super.removeColor()
        switch filter {
        case .desserts:
            self.iconView.image = Icons.dessertFilled
            break
        case .goodCoffee:
            self.iconView.image = Icons.cupFilled
        default:
            return
        }
    }
    
    
}
