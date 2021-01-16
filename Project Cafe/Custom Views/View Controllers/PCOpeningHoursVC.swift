//
//  PCOpeningHoursVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/13.
//

import UIKit

class PCOpeningHoursVC: UIViewController {
    
    let containerView   = PCAlertContainerView()
    var iconView: UIImageView!
    var titleLabel: PCTitleLabel!
    var cancelButton: UIButton!
    var dayButtons: [UIButton] = []
    var dayButtonStackView: UIStackView!
    var firstTextField: PCDatePickerTextField!
    var secondTextField: PCDatePickerTextField!
    var firstDoneButton: UIBarButtonItem!
    var secondDoneButton: UIBarButtonItem!
    
    var clearButton: PCIconButton!
    var saveButton: PCIconButton!
    
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
        configureStackView()
        configureTextFields()
        configureClearButton()
        configureSaveButton()
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
        iconView = UIImageView(image: Icons.calendarIcon)
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
    
    func configureLabel() {
        titleLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        titleLabel.font = .systemFont(ofSize: 20, weight: .black)
        titleLabel.text = "營業時間"
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -10)
        ])
    }
    
    func configureStackView() {
        for num in 1 ... 7 {
            var dayButton = UIButton()
            dayButton.translatesAutoresizingMaskIntoConstraints = false
            dayButton.layer.cornerRadius = 15
            dayButton.backgroundColor = .systemGray4
            dayButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
            dayButton.setTitleColor(.black, for: .normal)
            dayButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
            dayButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
            dayButton.addTarget(self, action: #selector(dayTapped), for: .touchUpInside)
            switch num {
            case 1: dayButton.setTitle("日", for: .normal); break
            case 2: dayButton.setTitle("一", for: .normal); break
            case 3: dayButton.setTitle("二", for: .normal); break
            case 4: dayButton.setTitle("三", for: .normal); break
            case 5: dayButton.setTitle("四", for: .normal); break
            case 6: dayButton.setTitle("五", for: .normal); break
            case 7: dayButton.setTitle("六", for: .normal); break
            default:
                break
            }
            dayButtons.append(dayButton)
        }
        dayButtonStackView = UIStackView(arrangedSubviews: dayButtons)
        dayButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        dayButtonStackView.axis = .horizontal
        dayButtonStackView.distribution = .fillEqually
        dayButtonStackView.spacing = 3
        view.addSubview(dayButtonStackView)
        
        NSLayoutConstraint.activate([
            dayButtonStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            dayButtonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            dayButtonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            dayButtonStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func dayTapped(_ sender: UIButton) {
        if (sender.backgroundColor == UIColor.systemGray4) {
            print("dayistapped")

        } else {
            sender.backgroundColor = UIColor.systemGray4
        }
    }
    func configureTextFields() {
        firstDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        firstTextField = PCDatePickerTextField(doneButton: firstDoneButton)
        view.addSubview(firstTextField)
        
        secondDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        secondTextField = PCDatePickerTextField(doneButton: secondDoneButton)
        view.addSubview(secondTextField)
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: dayButtonStackView.bottomAnchor, constant: 20),
            firstTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstTextField.widthAnchor.constraint(equalToConstant: 110),
            firstTextField.heightAnchor.constraint(equalToConstant: 30),
            
            secondTextField.topAnchor.constraint(equalTo: dayButtonStackView.bottomAnchor, constant: 20),
            secondTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            secondTextField.widthAnchor.constraint(equalToConstant: 110),
            secondTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    func configureClearButton () {
        clearButton = PCIconButton(iconImage: Icons.minusIcon, title: "清除")
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            clearButton.widthAnchor.constraint(equalToConstant: 110),
            clearButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            clearButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureSaveButton () {
        saveButton = PCIconButton(iconImage: Icons.storeIcon, title: "儲存")
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            saveButton.widthAnchor.constraint(equalToConstant: 110),
            saveButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
