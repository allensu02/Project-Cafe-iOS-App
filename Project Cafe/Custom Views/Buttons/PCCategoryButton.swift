//
//  PCCategoryButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/8.
//

import UIKit
class PCCategoryButton: PCIconButton {
    
    var category: Category?
    var filterList: [Filter] = []
    init(iconImage: UIImage, category: Category) {
        super.init(iconImage: iconImage, title: category.rawValue)
        self.category = category
        setFilters()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFilters() {
        switch category {
        case .drinkCoffee:
            filterList = [Filter.goodCoffee]
            return
        case .work:
            filterList = [Filter.noLimit, Filter.wifi, Filter.outlets, Filter.quiet]
            return
        case .relax:
            filterList = [Filter.quiet, Filter.noLimit]
            return
        case .groupMeal:
        filterList = [Filter.mrt]
            return
        case .none:
            filterList = []
            return
        }
    }
    
}
