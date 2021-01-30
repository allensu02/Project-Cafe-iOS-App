//
//  ListResultsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/30.
//

import UIKit

class ListResultsVC: UIViewController {

    var cafeList: [Cafe] = []
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = Colors.navyBlue
        title = "Results"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    func configure() {
        view.backgroundColor = .systemGray4
//        print(cafeList)
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.backgroundColor = .systemGray4
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 300
        tableView.register(PCCafeListCell.self, forCellReuseIdentifier: "cafeCell")
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

}

extension ListResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cafeCell") as? PCCafeListCell else {
            print("error with cafe list cell")
            return UITableViewCell()
        }
        
        cell.configure(cafe: cafeList[indexPath.row])
        
        return cell
    }
    
    
}
