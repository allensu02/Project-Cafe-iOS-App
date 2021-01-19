//
//  ViewController.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    var topView: PCHomeTopView!
    var buttonOne: PCHomeScreenButton!
    var newButtonOne: PCNewHomeScreenButton!
    var newButtonTwo: PCNewHomeScreenButton!
    var buttonTwo: PCHomeScreenButton!
    var stackView: UIStackView!
    var locationManager: CLLocationManager!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureTopView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        configureButton()
    }
    
    func configureTopView() {
        topView = PCHomeTopView()
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height*0.6)
        ])
    }
    
    func configureButton() {
//        buttonOne = PCHomeScreenButton(icon: UIImage(systemName: "mappin.and.ellipse")!)
//        buttonOne.buttonLabel.text = "離我最近"
//        buttonOne.addTarget(self, action: #selector(goToResults), for: .touchUpInside)
//        buttonTwo = PCHomeScreenButton(icon: UIImage(systemName: "text.badge.plus")!)
//        buttonTwo.buttonLabel.text = "偏好篩選"
//        buttonTwo.addTarget(self, action: #selector(goToFilterStrings), for: .touchUpInside)
        
        newButtonOne = PCNewHomeScreenButton(icon: Icons.homeOneIcon, smallText: "偏好篩選", largeText: "我想找一家適合...", backgroundColor: Colors.navyBlue)
        newButtonOne.addTarget(self, action: #selector(goToFilter), for: .touchUpInside)
        newButtonTwo = PCNewHomeScreenButton(icon: Icons.homeTwoIcon, smallText: "離我最近", largeText: "附近有什麼咖啡廳?", backgroundColor: Colors.lightBrown)
        newButtonTwo.largeLabel.textColor = Colors.navyBlue
        newButtonTwo.smallLabel.textColor = Colors.navyBlue
        newButtonTwo.addTarget(self, action: #selector(goToResults), for: .touchUpInside)

        stackView = UIStackView(arrangedSubviews: [newButtonOne, newButtonTwo])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 70),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    
    
    @objc func goToFilter() {
        let filterVC = FilterVC()
        navigationController?.pushViewController(filterVC, animated: true)
//        NetworkManager.shared.getWeather(city: "taipei") { (cafe) in
//            print("cafe: \(cafe.weather[0].main)")
//            self.presentPCAlertOnMainThread(title: "Test", message: "testtttt", buttonTitle: "Ok")
//        }
    }

    @objc func goToResults() {
        let resultsVC = ResultsVC()
        locationManager = CLLocationManager()
        resultsVC.initialLocation = locationManager.location
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

