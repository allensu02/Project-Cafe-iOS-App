//
//  PCCategoryListView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class PCFilterListView: UIView {
    var button1: PCFilterButton!
    var button2: PCFilterButton!
    var button3: PCFilterButton!
    var button4: PCFilterButton!
    var button5: PCFilterButton!
    var button6: PCFilterButton!
    var button7: PCFilterButton!
    var button8: PCFilterButton!
    var button9: PCFilterButton!
    var button10: PCFilterButton!

    var leftSV: UIView!
    var rightSV: UIView!
    var filterButtons: [PCFilterButton] = []
    var buttonSV: UIStackView!
    var topLabel: PCTitleLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure() {
        configureLabel()
        configureSV()
    }
    
    func configureLabel () {
        topLabel = PCTitleLabel(textAlignment: .left, fontSize: 25)
        topLabel.text = "條件"
        addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configureSV() {
        let noLimit = PCFilterButton(iconImage: Icons.clockIcon, filter: .noLimit)
        let openNow = PCFilterButton(iconImage: Icons.storeIcon, filter: .openNow)
        let outlets = PCFilterButton(iconImage: Icons.outletIcon, filter: .outlets)
        let goodCoffee = PCFilterButton(iconImage: Icons.cupFilled, filter: .goodCoffee)
        let mrt = PCFilterButton(iconImage: Icons.mrtIcon, filter: .mrt)
        let seats = PCFilterButton(iconImage: Icons.seatsIcon, filter: .seats)
        let price = PCFilterButton(iconImage: Icons.priceIcon, filter: .price)
        let desserts = PCFilterButton(iconImage: Icons.dessertFilled, filter: .desserts)
        let wifi = PCFilterButton(iconImage: Icons.wifiIcon, filter: .wifi)
        let quiet = PCFilterButton(iconImage: Icons.quietIcon, filter: .quiet)
        let openTime = PCFilterButton(iconImage: Icons.calendarIcon, filter: .openTime)
        let meals = PCFilterButton(iconImage: Icons.foodIcon, filter: .meals)
        filterButtons = [noLimit, openNow, outlets, goodCoffee, mrt, seats, price, desserts, wifi, quiet, openTime, meals]
        
        leftSV = createSV(buttons: [filterButtons[0], filterButtons[1], filterButtons[4], filterButtons[5], filterButtons[6], filterButtons[7]])
        rightSV = createSV(buttons: [filterButtons[2], filterButtons[3], filterButtons[8], filterButtons[9], filterButtons[10], filterButtons[11]])
        for button in filterButtons {
            button.isTapped = false
        }
        buttonSV = UIStackView(arrangedSubviews: [leftSV, rightSV])
        buttonSV.translatesAutoresizingMaskIntoConstraints = false
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        buttonSV.spacing = 10
        buttonSV.backgroundColor = .systemBackground
        addSubview(buttonSV)
        NSLayoutConstraint.activate([
            buttonSV.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 15),
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for button in filterButtons {
            button.addTarget(self, action: #selector(FilterSelected), for: .touchUpInside)
        }
    }
    
    func createSV(buttons: [UIView]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 10
        return sv
    }
    
    @objc func FilterSelected(sender: PCFilterButton!) {
        if (sender.isTapped) {
            sender.removeColor()
            sender.isTapped = false
        } else {
            sender.addColor()
            sender.isTapped = true
        }
    }

}
