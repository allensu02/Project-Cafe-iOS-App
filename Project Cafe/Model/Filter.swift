//
//  FilterString.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/3.
//

import Foundation

class Filter {
    var type: FilterString
    var button: PCIconButton!
    init (type: FilterString, button: PCIconButton) {
        self.type = type
        self.button = button
    }
}
