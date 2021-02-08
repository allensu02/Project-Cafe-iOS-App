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
    var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configureBackgroundImageView()
        configureSearchBar()
        configureMainLabel()
        //configureKnowButton()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackgroundImageView() {
        backgroundImageView = UIImageView(image: Images.homeScreenImage)
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
        //updates the layout for the next run loop
        setNeedsLayout()
        //updates all layouts right now
        layoutIfNeeded()
        NSLayoutConstraint.activate([
            mainLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            mainLabel.widthAnchor.constraint(equalToConstant: 200),
            mainLabel.heightAnchor.constraint(equalToConstant: 130)
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
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "搜尋店名"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = .systemBackground
        searchBar.layer.shadowColor = UIColor.black.cgColor
        searchBar.layer.shadowOpacity = 0.25
        searchBar.layer.shadowOffset = CGSize(width: 5, height: 5)
        searchBar.layer.shadowRadius = 10
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}


