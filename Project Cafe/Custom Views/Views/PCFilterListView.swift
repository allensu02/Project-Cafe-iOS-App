//
//  PCCategoryListView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class PCFilterListView: UIView {
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
    var iconButtons: [PCIconButton] = []
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
        leftSV = createSV(buttons: [iconButtons[0], iconButtons[1], iconButtons[4], iconButtons[5], iconButtons[6]])
        rightSV = createSV(buttons: [iconButtons[2], iconButtons[3], iconButtons[7], iconButtons[8]])
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
        NSLayoutConstraint.activate([
            buttonSV.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 15),
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        for button in iconButtons {
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
    
    @objc func FilterSelected(sender: PCIconButton!) {
        if (sender.isTapped) {
            sender.removeColor()
            sender.isTapped = false
            for button in iconButtons {
                button.removeColor()
            }
        } else {
            sender.addColor()
            sender.isTapped = true
        }
    }

}
