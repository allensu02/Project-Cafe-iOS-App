//
//  ViewController.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

class HomeVC: UIViewController {

    var nearMeButton: PCButton!
    var filterButton: PCButton!
    var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        configureLogo()
        configureNearMeButton()
        configureFilterButton()
    }
    
    func configureLogo() {
        logo = UIImageView(image: Images.defaultLogo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logo)
        
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 250),
            logo.widthAnchor.constraint(equalToConstant: 250),
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    func configureNearMeButton () {
        nearMeButton = PCButton(backgroundColor: Colors.defaultBrown, title: "Cafes Near Me")
        view.addSubview(nearMeButton)
        nearMeButton.addTarget(self, action: #selector(goToResults), for: .touchUpInside)

        NSLayoutConstraint.activate([
            nearMeButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 100),
            nearMeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            nearMeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nearMeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureFilterButton () {
        filterButton = PCButton(backgroundColor: Colors.defaultBrown, title: "Apply Filters")
        view.addSubview(filterButton)
        filterButton.addTarget(self, action: #selector(goToFilters), for: .touchUpInside)
        NSLayoutConstraint.activate([
            filterButton.topAnchor.constraint(equalTo: nearMeButton.bottomAnchor, constant: 100),
            filterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            filterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            filterButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    @objc func goToFilters() {
        let filtersVC = FiltersVC()
        navigationController?.pushViewController(filtersVC, animated: true)
    }

    @objc func goToResults() {
        let resultsVC = ResultsVC()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
}

