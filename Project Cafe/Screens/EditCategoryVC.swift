//
//  EditCategoryVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class EditCategoryVC: UIViewController {

    var instructionLabel: PCTitleLabel!
    var tableView: UITableView!
    var categories: CategoryList!
    var myCategoryList: []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "編輯類別"
        view.backgroundColor = .systemBackground
        categories = CategoryList()
        myCategoryList = [categories.work, categories.groupMeal, categories.relax, categories.drinkCoffee]
        configureUI()
    }
    
    func configureUI() {
        configureLabel()
        configureTableView()
    }
    
    func configureLabel() {
        instructionLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        instructionLabel.textColor = .systemGray
        instructionLabel.text = "點擊來編輯 / 長按拖移來改變順序"
        view.addSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            instructionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            
        ])
    }

}

extension EditCategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
