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
    var button5: PCIconButton!
    var button6: PCIconButton!
    var button7: PCIconButton!
    var button8: PCIconButton!
    var button9: PCIconButton!
    var button10: PCIconButton!

    var leftSV: UIView!
    var rightSV: UIView!
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
        
        setSV()        
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
    
    func expandView() {
        button1 = PCIconButton(iconImage: Icons.clockIcon, title: FilterString.noLimit.rawValue)
        button2 = PCIconButton(iconImage: Icons.outletIcon, title: FilterString.outlets.rawValue)
        button3 = PCIconButton(iconImage: Icons.coffeeIcon, title: FilterString.goodCoffee.rawValue)
        button4 = PCIconButton(iconImage: Icons.storeIcon, title: FilterString.openNow.rawValue)
        button5 = PCIconButton(iconImage: Icons.wifiIcon, title: FilterString.wifi.rawValue)
        button6 = PCIconButton(iconImage: Icons.quietIcon, title: FilterString.quiet.rawValue)
        button7 = PCIconButton(iconImage: Icons.mrtIcon, title: FilterString.mrt.rawValue)
        button8 = PCIconButton(iconImage: Icons.calendarIcon, title: FilterString.openTime.rawValue)
        button9 = PCIconButton(iconImage: Icons.priceIcon, title: FilterString.price.rawValue)
        var filterList = FilterList()
        iconButtons = [filterList.noLimit.button,
                       filterList.outlets.button,
                       filterList.openNow.button,
                       filterList.goodCoffee.button,
                       filterList.mrt.button,
                       filterList.price.button,
                       filterList.wifi.button,
                       filterList.quiet.button,
                       filterList.openTime.button]
        leftSV = createSV(buttons: [iconButtons[0], iconButtons[1], iconButtons[5], iconButtons[6], iconButtons[7]])
        rightSV = createSV(buttons: [iconButtons[2], iconButtons[3], iconButtons[8], iconButtons[9]])
        for button in iconButtons {
            button.isTapped = false
        }
        buttonSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        buttonSV.translatesAutoresizingMaskIntoConstraints = false
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        buttonSV.spacing = 10
        buttonSV.backgroundColor = .systemBackground
        addSubview(buttonSV)
        print("ran")
        NSLayoutConstraint.activate([
            buttonSV.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    func configureMoreButton() {
        moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.titleLabel?.text = "更多"
        moreButton.backgroundColor = .cyan
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
    
    func setSV() {
        if (headerText == "類別") {
            iconButtons = [CategoryList.work.button, CategoryList.groupMeal.button, CategoryList.relax.button, CategoryList.drinkCoffee.button]
        } else {
            iconButtons = [FilterList.noLimit.button, FilterList.outlets.button, FilterList.openNow.button, FilterList.goodCoffee.button]
        }
        leftSV = createSV(buttons: [iconButtons[0], iconButtons[1]])
        rightSV = createSV(buttons: [iconButtons[2], iconButtons[3]])
    }
    
    func createSV(buttons: [UIView]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }
    
}
