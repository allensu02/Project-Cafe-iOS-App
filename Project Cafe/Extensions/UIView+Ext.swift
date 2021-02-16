//
//  UIView+Ext.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    func roundDistance(distance: Double) -> Int {
        return 10 * Int((distance / 10.0).rounded())
    }
}
