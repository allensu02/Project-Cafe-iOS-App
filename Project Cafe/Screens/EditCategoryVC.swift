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
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "編輯類別"
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    func configureUI() {
        configureLabel()
        configureTableView()
        tableView.reloadData()
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.setRightBarButton(addButton, animated: true)
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
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.register(PCCategoryCell.self, forCellReuseIdentifier: "catCell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

}

extension EditCategoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "catCell") as? PCCategoryCell else {
            print("error with category cell")
            return UITableViewCell()
        }
        if indexPath.row == 1 {
            cell.category = .work
        }
        if indexPath.row == 2 {
            cell.category = .relax
        }
        if indexPath.row == 3 {
            cell.category = .drinkCoffee
        }
        if indexPath.row == 4 {
            cell.category = .groupMeal
        }
        cell.configure()
        //cell.textLabel?.text = cell.category.rawValue
        return cell
    }
    
    @objc func addTapped() {
        let newCatVC = NewCategoryVC()
        navigationController?.pushViewController(newCatVC, animated: true)
    }
    
}
