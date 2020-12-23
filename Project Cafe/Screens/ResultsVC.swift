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
        configureLabel()
    }
    
    func configureLabel () {
        tempLabel = PCTitleLabel(textAlignment: .center, fontSize: 25)
        tempLabel.text = "Results Page"
        view.addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
    

}
