//
//  PCPriceVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/18.
//

import UIKit

class PCPriceVC: UIViewController {

    let containerView   = PCAlertContainerView()
    var moneyButtonOne: PCButton!
    var moneyButtonTwo: PCButton!
    var moneyButtonThree: PCButton!
    var iconView: UIImageView!
    var titleLabel: PCTitleLabel!
    var cancelButton: UIButton!
    var clearButton: PCIconButton!
    var lineView: UIView!
    var saveButton: PCIconButton!
    var moneyButtons: [PCButton] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configureContainerView()
        configureIconView()
        configureCancelButton()
        configureLabel()
        configureClearButton()
        configureMoneyButtons()
        configureLine()
        configureSaveButton()
        
    }
    
    func configureMoneyButtons() {
        moneyButtonThree = PCButton(backgroundColor: .white, title: "$$$")
        moneyButtonTwo = PCButton(backgroundColor: .white, title: "$$")
        moneyButtonOne = PCButton(backgroundColor: .white, title: "$")
        moneyButtons.append(moneyButtonThree)
        moneyButtons.append(moneyButtonTwo)
        moneyButtons.append(moneyButtonOne)

        for button in moneyButtons {
            button.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
            button.setTitleColor(Colors.navyBlue, for: .normal)
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 2
            button.layer.borderColor = Colors.navyBlue.cgColor
            button.addTarget(self, action: #selector(moneyTapped(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
        
        
        NSLayoutConstraint.activate([
            moneyButtonThree.widthAnchor.constraint(equalToConstant: 90),
            moneyButtonThree.heightAnchor.constraint(equalToConstant: 40),
            moneyButtonThree.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: -5),
            moneyButtonThree.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 50),
            
            moneyButtonTwo.trailingAnchor.constraint(equalTo: moneyButtonThree.leadingAnchor, constant: 10),
            moneyButtonTwo.widthAnchor.constraint(equalToConstant: 90),
            moneyButtonTwo.heightAnchor.constraint(equalToConstant: 40),
            moneyButtonTwo.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 50),
            
            moneyButtonOne.trailingAnchor.constraint(equalTo: moneyButtonTwo.leadingAnchor, constant: 10),
            moneyButtonOne.widthAnchor.constraint(equalToConstant: 90),
            moneyButtonOne.heightAnchor.constraint(equalToConstant: 40),
            moneyButtonOne.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 50),
        ])
        
    }
    
    @objc func moneyTapped(_ sender: PCButton) {
        resetButtons()
        sender.backgroundColor = Colors.navyBlue
        sender.setTitleColor(.white, for: .normal)
        
    }
    
    
    func configureContainerView() {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureIconView() {
        iconView = UIImageView(image: Icons.calendarOutline)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureCancelButton() {
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 15),
            cancelButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureLabel() {
        titleLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        titleLabel.font = .systemFont(ofSize: 20, weight: .black)
        titleLabel.text = "價位"
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -10)
        ])
    }
    
    func configureClearButton () {
        clearButton = PCIconButton(iconImage: Icons.minusIcon, title: "清除")
        clearButton.layer.cornerRadius = 6
        view.addSubview(clearButton)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            clearButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            clearButton.widthAnchor.constraint(equalToConstant: 110),
            clearButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            clearButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc func clearTapped() {
        resetButtons()
    }
    
    func resetButtons() {
        for button in moneyButtons {
            button.backgroundColor = UIColor.white
            button.setTitleColor(Colors.navyBlue, for: .normal)
        }
    }
    func configureSaveButton () {
        saveButton = PCIconButton(iconImage: Icons.storeOutline, title: "儲存")
        saveButton.layer.cornerRadius = 6
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 110),
            saveButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc func saveTapped() {
        dismiss(animated: true)
    }
    
    func configureLine() {
        lineView = UIView()
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = UIColor.systemGray4.cgColor
        view.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: moneyButtonThree.bottomAnchor, constant: 15),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
