//
//  ViewController.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/21.
//

import UIKit
import MapKit

class HomeVC: PCDataLoadingVC {

    var topView: PCHomeTopView!
    var buttonOne: PCHomeScreenButton!
    var newButtonOne: PCNewHomeScreenButton!
    var newButtonTwo: PCNewHomeScreenButton!
    var buttonTwo: PCHomeScreenButton!
    var stackView: UIStackView!
    var locationManager: CLLocationManager!
    
    private let completer = MKLocalSearchCompleter()

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
        //tempAddCard()
        self.navigationController?.navigationBar.barTintColor = Colors.navyBlue
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func configureTopView() {
        topView = PCHomeTopView()
        
        topView.searchBar.delegate = self
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
    
    func tempAddCard() {
        let pcCardView = PCCafeCardView()
        
        view.addSubview(pcCardView)
        pcCardView.set(cafe: Cafe(name: "Big Cafe", city: "Taipei", address: nil, operatingHours: nil, openNow: true, url: nil, distance: 300, latitude: 120, longitude: 120, mrtStation: "Blah blah", wifi: true, timeLimit: true, plugs: true, nearMrt: true, pourOver: false, singleOrigin: true, desserts: true, meals: true, priceLevel: 3, seats: 4, quietness: 3, tastiness: 4, photos: nil))
        NSLayoutConstraint.activate([
            pcCardView.heightAnchor.constraint(equalToConstant: Numbers.cardViewHeight),
            pcCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pcCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            pcCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    override func viewWillDisappear(_ animated: Bool) {
        dismissLoadingView()
    }
}


extension HomeVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let listResultsVC = ListResultsVC()
        if (searchBar.text == nil || searchBar.text == "") {
            presentPCAlertOnMainThread(title: "未輸入店名!", message: "請輸入您想搜尋的店名. ☕", buttonTitle: "好")
            return
        }
        isEditing = false
        locationManager = CLLocationManager()
        dismissKeyboard()
        showLoadingView()
        NetworkManager.shared.getCafes(keyword: searchBar.text!, limit: 15, lat: locationManager.location!.coordinate.latitude, lon: locationManager.location!.coordinate.longitude) { (data) in
            let cafeResults = data.results
            DispatchQueue.main.async {
                let listResultsVC = ListResultsVC()
                listResultsVC.cafeList = cafeResults
                listResultsVC.configure()
                self.navigationController?.pushViewController(listResultsVC, animated: true)
                searchBar.text = ""
            }
        }
    }
}

