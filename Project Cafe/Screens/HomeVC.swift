//
//  ViewController.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit

class HomeVC: UIViewController {

    var topView: PCHomeTopView!
    var buttonOne: PCHomeScreenButton!
    var buttonTwo: PCHomeScreenButton!
    var stackView: UIStackView!
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
        buttonOne = PCHomeScreenButton(icon: UIImage(systemName: "mappin.and.ellipse")!)
        buttonOne.buttonLabel.text = "離我最近"
        buttonOne.addTarget(self, action: #selector(goToResults), for: .touchUpInside)
        buttonTwo = PCHomeScreenButton(icon: UIImage(systemName: "text.badge.plus")!)
        buttonTwo.buttonLabel.text = "偏好篩選"
        buttonTwo.addTarget(self, action: #selector(goToFilterStrings), for: .touchUpInside)
        stackView = UIStackView(arrangedSubviews: [buttonOne, buttonTwo])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 70),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    
    
    @objc func goToFilterStrings() {
        let filterVC = FilterVC()
        navigationController?.pushViewController(filterVC, animated: true)
//        NetworkManager.shared.getWeather(city: "taipei") { (cafe) in
//            print("cafe: \(cafe.weather[0].main)")
//            self.presentPCAlertOnMainThread(title: "Test", message: "testtttt", buttonTitle: "Ok")
//        }
    }

    @objc func goToResults() {
        let resultsVC = ResultsVC()
        print("hello")
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

