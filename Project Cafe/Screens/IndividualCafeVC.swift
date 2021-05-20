//
//  IndividualCafeVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/2/5.
//

import UIKit
import MapKit

class IndividualCafeVC: UIViewController {

    var cafe: Cafe!
    var topView: PCIndividualTopView!
    var mainView: PCIndividualMainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = Colors.navyBlue
        title = "Cafe"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray4
        configureTopView()
        configureMainView()
    }
    
    func configureTopView() {
        topView = PCIndividualTopView(cafe: cafe)
        topView.mapButton.addTarget(self, action: #selector(mapPressed), for: .touchUpInside)
        view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    func configureMainView() {
        mainView = PCIndividualMainView(cafe: cafe)
        view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func mapPressed() {
//        let resultsVC = ResultsVC()
//        resultsVC.initialLocation = CLLocation(latitude: cafe.latitude!, longitude: cafe.longitude!)
//        navigationController?.pushViewController(resultsVC, animated: true)
        guard let navArray = navigationController?.viewControllers else { return }
        guard let prevVC = navArray[navArray.count - 2] as? ResultsVC else { return }
        prevVC.initialLocation = CLLocation(latitude: cafe.latitude!, longitude: cafe.longitude!)
        navigationController?.popViewController(animated: true)
    }
    
}
