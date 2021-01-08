//
//  NewCategoryVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class NewCategoryVC: UIViewController {

    var instructionLabel: PCTitleLabel!
    var nameView: PCCategoryNameView!
    var filterList: PCFilterListView!
    var saveButton: PCButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "新增類別"
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    func configureUI() {
        configureLabel()
        configureNameView()
        configureListView()
        configureSaveButton()
    }
    
    func configureLabel() {
        instructionLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        instructionLabel.textColor = .systemGray
        instructionLabel.text = "幫助你更快找到適合的咖啡廳"
        view.addSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureNameView() {
        nameView = PCCategoryNameView()
        view.addSubview(nameView)
        NSLayoutConstraint.activate([
            nameView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 20),
            nameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureListView() {
        filterList = PCFilterListView()
        view.addSubview(filterList)
        NSLayoutConstraint.activate([
            filterList.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 60),
            filterList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filterList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filterList.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureSaveButton() {
        saveButton = PCButton(backgroundColor: Colors.defaultBrown, title: "找咖啡廳！")
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
