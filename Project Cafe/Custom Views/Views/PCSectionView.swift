//
//  PCSectionView.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/29.
//

import UIKit

class PCSectionView: UIView {
    
    var headerText: String!
    var headerLabel: PCTitleLabel!
    var editButton: UIButton!
    var iconButtons: [PCIconButton] = []
    var buttonSV: UIStackView!
    var moreButton: UIButton!
    
    var button1: PCIconButton!
    var button2: PCIconButton!
    var button3: PCIconButton!
    var button4: PCIconButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(titleText: String) {
        super.init(frame: .zero)
        self.headerText = titleText
        configure()
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureHeaderLabel()
        configureEditButton()
        configureStackView()
        configureMoreButton()
    }
    
    func configureHeaderLabel() {
        headerLabel = PCTitleLabel(textAlignment: .left, fontSize: 30)
        headerLabel.textColor = Colors.defaultBrown
        headerLabel.text = headerText
        addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureEditButton() {
        editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.titleLabel?.text = "編輯"
        editButton.setTitle("編輯", for: .normal)
        editButton.setTitleColor(Colors.defaultBrown, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        editButton.titleLabel?.textAlignment = .right
        addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 50),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            editButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    func configureStackView() {
        var leftSV: UIView!
        var rightSV: UIView!
        
        setButtons()
        iconButtons = [button1, button2, button3, button4]
        leftSV = createSV(buttons: [button1, button2])
        rightSV = createSV(buttons: [button3, button4])
        
        buttonSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        buttonSV.translatesAutoresizingMaskIntoConstraints = false
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        buttonSV.spacing = 10
        buttonSV.backgroundColor = .systemBackground
        addSubview(buttonSV)
        NSLayoutConstraint.activate([
            buttonSV.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.heightAnchor.constraint(equalToConstant: 100)
        ])
  
    }
    
    func configureMoreButton() {
        moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.titleLabel?.text = "更多"
        moreButton.setTitle("更多", for: .normal)
        moreButton.setTitleColor(Colors.defaultBrown, for: .normal)
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        moreButton.titleLabel?.textAlignment = .right
        addSubview(moreButton)
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: buttonSV.bottomAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 50),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setButtons() {
        if (headerText == "類別") {
            button1 = PCIconButton(iconImage: Icons.computerIcon, title: Category.work.rawValue)
            button2 = PCIconButton(iconImage: Icons.coffeeIcon, title: Category.drinkCoffee.rawValue)
            button3 = PCIconButton(iconImage: Icons.relaxIcon, title: Category.relax.rawValue)
            button4 = PCIconButton(iconImage: Icons.groupIcon, title: Category.groupMeal.rawValue)
            
        } else {
            button1 = PCIconButton(iconImage: Icons.clockIcon, title: Filter.noLimit.rawValue)
            button2 = PCIconButton(iconImage: Icons.outletIcon, title: Filter.outlets.rawValue)
            button3 = PCIconButton(iconImage: Icons.coffeeIcon, title: Filter.goodCoffee.rawValue)
            button4 = PCIconButton(iconImage: Icons.storeIcon, title: Filter.openNow.rawValue)
        }
    }
    
    func createSV(buttons: [UIView]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }
    
}
