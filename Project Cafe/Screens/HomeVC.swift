//
//  ViewController.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

class HomeVC: UIViewController {

    var topView: PCHomeTopView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        configureTopView()
    }
    
    func configureTopView() {
        topView = PCHomeTopView()
        view.addSubview(topView)
//        PCHomeTopView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.4))
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height*0.6)
        ])
    }
    
    
    
    @objc func goToFilters() {
        let filtersVC = FiltersVC()
        //navigationController?.pushViewController(filtersVC, animated: true)
        NetworkManager.shared.getWeather(city: "taipei") { (cafe) in
            print("cafe: \(cafe.weather[0].main)")
            self.presentPCAlertOnMainThread(title: "Test", message: "testtttt", buttonTitle: "Ok")
        }
    }

    @objc func goToResults() {
        let resultsVC = ResultsVC()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
}

