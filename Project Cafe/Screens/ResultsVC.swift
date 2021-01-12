//
//  ResultsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit

class ResultsVC: UIViewController {

    var tempLabel: PCTitleLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "編輯類別"
        configureLabel()
        configureMap()
    }
    
    func configureMap() {
        
    }
    
    func configureLabel () {
        
        tempLabel = PCTitleLabel(textAlignment: .center, fontSize: 25)
        tempLabel.text = "Results Page"
        view.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NetworkManager.shared.getCafes(lat: 25.023367112238798, lon: 121.53907377663803, limit: 154) { (myResults) in
            DispatchQueue.main.async {
                self.tempLabel.text = myResults.results[0].name + "\(myResults.count)"

            }
        }
    }
    
    

    
    

}
