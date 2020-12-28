//
//  PCHomeTopView.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/27.
//

import UIKit

class PCHomeTopView: UIView {

    var backgroundImageView: UIImageView!
    var mainLabel: PCTitleLabel!
    var knowButton: PCButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
        configureBackgroundImageView()
        configureMainLabel()
        configureKnowButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackgroundImageView() {
        backgroundImageView = UIImageView(image: Images.cafePlaceholderImage)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configureMainLabel() {
        mainLabel = PCTitleLabel(textAlignment: .left, fontSize: 10)
        mainLabel.font = .systemFont(ofSize: 40, weight: .bold)
        
        mainLabel.textColor = .white
        mainLabel.text = "找到適合你的咖啡廳"
        mainLabel.numberOfLines = 2
        addSubview(mainLabel)
        setNeedsLayout()
        layoutIfNeeded()
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: topAnchor, constant: self.frame.height * 0.25),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            mainLabel.widthAnchor.constraint(equalToConstant: self.frame.width * 0.9),
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.frame.height * 0.5)
        ])
    }
    
    func configureKnowButton() {
        knowButton = PCButton(backgroundColor: .clear, title: "我知道這家！")
        knowButton.titleLabel?.font.withSize(10)
        knowButton.titleLabel?.textAlignment = .center
        addSubview(knowButton)
        NSLayoutConstraint.activate([
            knowButton.topAnchor.constraint(equalTo: mainLabel.bottomAnchor),
            knowButton.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor, constant: 15),
            knowButton.widthAnchor.constraint(equalToConstant: self.frame.width * 0.5),
            knowButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -self.frame.height * 0.25)
        ])
    }
    
    func configureSearchBar() {
        
    }
}
