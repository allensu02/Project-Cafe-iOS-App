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
    var filterButtons: [PCFilterButton]!
    var categoryButtons: [PCCategoryButton]!
    var buttonSV: UIStackView!
    var moreButton: UIButton!
    var hideButton: UIButton!
    
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
        headerLabel.textColor = Colors.navyBlue
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
        editButton.setTitleColor(Colors.navyBlue, for: .normal)
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
        moreButton.setTitleColor(Colors.navyBlue, for: .normal)
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
            setCategoryButtons()
            leftSV = createSV(buttons: [categoryButtons[0], categoryButtons[1]])
            rightSV = createSV(buttons: [categoryButtons[2], categoryButtons[3]])
        } else {
            setFilterButtons()
            leftSV = createSV(buttons: [filterButtons[0], filterButtons[1]])
            rightSV = createSV(buttons: [filterButtons[2], filterButtons[3]])
        }
    }
    
    func expandFilter() {
        buttonSV.removeFromSuperview()
        buttonSV = nil
        moreButton.isHidden = true
        if (hideButton != nil) {
            hideButton.isHidden = false
        }
        
        leftSV = createSV(buttons: [filterButtons[0], filterButtons[1], filterButtons[4], filterButtons[5], filterButtons[6], filterButtons[7]])
        rightSV = createSV(buttons: [filterButtons[2], filterButtons[3], filterButtons[8], filterButtons[9], filterButtons[10], filterButtons[11]])
    
        buttonSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        buttonSV.translatesAutoresizingMaskIntoConstraints = false
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        buttonSV.spacing = 10
        addSubview(buttonSV)
        NSLayoutConstraint.activate([
            buttonSV.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.heightAnchor.constraint(equalToConstant: 340)
        ])
        //configureHideButton()
    }
    
    func configureHideButton() {
        hideButton = UIButton()
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle("收回", for: .normal)
        hideButton.setTitleColor(Colors.navyBlue, for: .normal)
        hideButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        hideButton.titleLabel?.textAlignment = .right
        addSubview(hideButton)
        NSLayoutConstraint.activate([
            hideButton.topAnchor.constraint(equalTo: buttonSV.bottomAnchor),
            hideButton.widthAnchor.constraint(equalToConstant: 50),
            hideButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            hideButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func reduce() {
        buttonSV.removeFromSuperview()
        buttonSV = nil
        hideButton.isHidden = true
        moreButton.isHidden = false
        configureStackView()
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: buttonSV.bottomAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 50),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setFilterButtons() {
        let noLimit = PCFilterButton(iconImage: Icons.clockOutline, filter: .noLimit)
        let openNow = PCFilterButton(iconImage: Icons.storeOutline, filter: .openNow)
        let outlets = PCFilterButton(iconImage: Icons.plugOutline, filter: .outlets)
        let goodCoffee = PCFilterButton(iconImage: Icons.cupOutline, filter: .goodCoffee)
        let mrt = PCFilterButton(iconImage: Icons.mrtOutline, filter: .mrt)
        let seats = PCFilterButton(iconImage: Icons.chairOutline, filter: .seats)
        let price = PCFilterButton(iconImage: Icons.moneyOutline, filter: .price)
        let desserts = PCFilterButton(iconImage: Icons.cakeOutline, filter: .desserts)
        let wifi = PCFilterButton(iconImage: Icons.wifiOutline, filter: .wifi)
        let quiet = PCFilterButton(iconImage: Icons.soundOutline, filter: .quiet)
        let openTime = PCFilterButton(iconImage: Icons.calendarOutline, filter: .openTime)
        let meals = PCFilterButton(iconImage: Icons.mealOutline, filter: .meals)
        filterButtons = [noLimit, openNow, outlets, goodCoffee, mrt, seats, price, desserts, wifi, quiet, openTime, meals]
    }
    
    func setCategoryButtons() {
        let work = PCCategoryButton(iconImage: Icons.computerIcon, category: .work)
        let groupMeal = PCCategoryButton(iconImage: Icons.groupIcon, category: .groupMeal)
        let relax = PCCategoryButton(iconImage: Icons.relaxIcon, category: .relax)
        let coffee = PCCategoryButton(iconImage: Icons.cupOutline, category: .drinkCoffee)
        
        categoryButtons = [work, groupMeal, relax, coffee]
    }
    
    func createSV(buttons: [UIView]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }
    
}
