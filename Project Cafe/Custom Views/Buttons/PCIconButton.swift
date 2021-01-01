//
//  PCIconButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/29.
//

import UIKit

class PCIconButton: UIButton {

    var iconImage: UIImage!
    var iconView: UIImageView!
    var text: String!
    var label: PCTitleLabel!
    var isTapped: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(iconImage: UIImage, title: String) {
        super.init(frame: .zero)
        self.iconImage = iconImage
        text = title
        configure()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure() {
        configureIconView()
        configureLabel()
        isTapped = false
        layer.borderColor = Colors.defaultBrown.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        setTitleColor(.red, for: .highlighted)
    }
    
    func changeColor(otherColor: UIColor) {
        if (isTapped) {
            layer.backgroundColor = UIColor.white.cgColor
            label?.textColor = Colors.defaultBrown
            iconView.tintColor = Colors.defaultBrown
            isTapped = false
        } else {
            layer.backgroundColor = otherColor.cgColor
            label?.textColor = .white
            iconView.tintColor = .white
            isTapped = true
        }
        
    }
    
    func configureIconView() {
        iconView = UIImageView(image: iconImage)
        iconView.tintColor = Colors.defaultBrown
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        addSubview(iconView)
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            iconView.heightAnchor.constraint(equalToConstant: 25),
            iconView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configureLabel() {
        label = PCTitleLabel(textAlignment: .left, fontSize: 20)
        label.text = text
        label.textColor = Colors.defaultBrown
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
    }

}
