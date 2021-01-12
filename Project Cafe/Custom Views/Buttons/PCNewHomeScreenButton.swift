//
//  PCNewHomeScreenButton.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/12.
//

import UIKit

class PCNewHomeScreenButton: UIButton {

    var myImage: UIImage!
    var myImageView: UIImageView!
    var smallText: String!
    var largeText: String!
    var largeLabel: PCTitleLabel!
    var smallLabel: PCTitleLabel!
    var labelStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(icon myImage: UIImage, smallText: String, largeText: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.myImage = myImage
        self.smallText = smallText
        self.largeText = largeText
        self.backgroundColor = backgroundColor
        configure()
    }
    
    func configure() {
        configureImage()
        configureLabels()
        layer.cornerRadius = 10
    }
    
    func configureImage() {
        myImageView = UIImageView(image: myImage)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(myImageView)
        
        NSLayoutConstraint.activate([
            myImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            myImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            myImageView.heightAnchor.constraint(equalToConstant: 120),
            myImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureLabels() {
        largeLabel = PCTitleLabel(textAlignment: .left, fontSize: 25)
        largeLabel.font = .systemFont(ofSize: 25, weight: .black)
        largeLabel.text = largeText
        largeLabel.minimumScaleFactor = 0.7
        largeLabel.textColor = .white
        smallLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        smallLabel.textColor = .white
        smallLabel.text = smallText
        
        labelStackView = UIStackView(arrangedSubviews: [smallLabel, largeLabel])
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.distribution = .fill
        labelStackView.spacing = 3
        labelStackView.isUserInteractionEnabled = false
        addSubview(labelStackView)
        
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelStackView.heightAnchor.constraint(equalToConstant: 50),
            labelStackView.trailingAnchor.constraint(equalTo: myImageView.leadingAnchor),
            labelStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    
    
}
