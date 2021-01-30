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
        view.backgroundColor = .systemBackground
//        print(cafeList)
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    

}
