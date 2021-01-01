//
//  PCHomeScreenButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/28.
//

import UIKit

class PCHomeScreenButton: UIButton {
    
    var myImage: UIImage!
    var iconImageView: UIImageView!
    var buttonLabel: PCTitleLabel!
    var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(icon myImage: UIImage) {
        super.init(frame: .zero)
        self.myImage = myImage
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.defaultBrown
        configureStackView()
    }
    
    func configureStackView() {
        iconImageView = UIImageView(image: myImage)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        buttonLabel = PCTitleLabel(textAlignment: .center, fontSize: 20)
        buttonLabel.textColor = .white
        buttonLabel.minimumScaleFactor = 0.5
        stackView = UIStackView(arrangedSubviews: [iconImageView, buttonLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.isUserInteractionEnabled = false
        //updates the layout for the next run loop
        setNeedsLayout()
        //updates all layouts right now
        layoutIfNeeded()
    
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}
