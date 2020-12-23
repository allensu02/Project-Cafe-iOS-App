//
//  PCButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

class PCButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.font = Fonts.merriweather
        titleLabel?.textAlignment = .center
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = Colors.defaultBrown.cgColor
        layer.borderWidth = 5
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

}
