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
}
