//
//  Category.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/3.
//

import Foundation

class Category{
    var type: CategoryString
    var button: PCIconButton!
    var presetFilters: [String]
    init (type: CategoryString, button: PCIconButton, presetFilters: [String]) {
        self.type = type
        self.button = button
        self.presetFilters = presetFilters
    }
}
