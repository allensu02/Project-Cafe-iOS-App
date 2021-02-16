//
//  ResultsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit
import MapKit


class ResultsVC: PCDataLoadingVC {
    
    var refreshButton: UIButton!
    var tempLabel: PCTitleLabel!
    let locationManager = CLLocationManager()
    var mapView: MKMapView!
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation!
    var initialLocation: CLLocation!
    var cardView: PCCafeCardView!
    var listButton: UIBarButtonItem!
    var totalCafeList: [Cafe] = []
    var activatedFilters: [PCFilterButton] = []
    var queryString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        configureUI()
        addCafes(location: initialLocation)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = Colors.navyBlue
        title = "Results"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.isHidden = true
    }
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        configureMap()
        configureCardView()
        configureRefreshButton()
        configureListButton()
    }
    
    func configureCardView() {
        cardView = PCCafeCardView(frame: .zero)
        view.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: Numbers.cardViewHeight)
        ])
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
        cardView.addGestureRecognizer(tap)
    }
    
    @objc func cardTapped() {
        let individualCafeVC = IndividualCafeVC()
        individualCafeVC.cafe = cardView.cafe
        individualCafeVC.configureUI()
        navigationController?.pushViewController(individualCafeVC, animated: true)
    }
    
    func addCafes(location: CLLocation) {
        print("ran add cafes")
        showLoadingView()
        NetworkManager.shared.getCafes(lat: location.coordinate.latitude, lon: location.coordinate.longitude, limit: 15, queryString: queryString) { (data) in
            self.updateCafes(data: data)
        }

    }
    
    func updateCafes(data: CafeResults) {
        print("running in closure")
        let cafeList = data.results
        var cafeAnnotations: [CafeOnMap] = []
        for cafe in cafeList {
            let thisCafe = CafeOnMap(cafe: cafe)
            cafeAnnotations.append(thisCafe)
        }
        self.totalCafeList.insert(contentsOf: cafeList, at: 0)
        DispatchQueue.main.async {
            
            self.mapView.addAnnotations(cafeAnnotations)
            if (cafeAnnotations.count > 0) {
                self.cardView.set(cafe: cafeAnnotations[0].cafe)
                self.mapView.selectAnnotation(cafeAnnotations[0], animated: true)
            } else {
                self.presentPCAlertOnMainThread(title: "無咖啡廳", message: "您搜尋的範圍沒有任何咖啡廳。請移動您的地圖，並按下[重新搜尋]來尋找新的咖啡廳 ☕", buttonTitle: "知道了")
            }
            self.refreshButton.isHidden = true
            print("updated annotations")
        }
        self.dismissLoadingView()
    }
    
    //handles errors and begins updating location
    func checkLocationAuthorization () {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            print("error")
        case .denied:
            let alertActionButton = presentPCAlertOnMainThread(title: "Location Denied", message: "Please turn on Location in Settings", buttonTitle: "Ok")
            alertActionButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            startTrackingUserLocation()
            break
        }
    }
    
    @objc func okTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func startTrackingUserLocation () {
        mapView.showsUserLocation = true
        centerViewOnInitialLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func centerViewOnInitialLocation() {
        
        let region = MKCoordinateRegion.init(center: initialLocation.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        
    }
    
    func configureMap() {
        mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    func configureRefreshButton () {
        refreshButton = UIButton()
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.layer.cornerRadius = 3
        refreshButton.backgroundColor = .white
        refreshButton.setTitle("重新搜尋", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        refreshButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        refreshButton.layer.cornerRadius = 15
        refreshButton.layer.shadowColor = UIColor.black.cgColor
        refreshButton.layer.shadowOpacity = 0.25
        refreshButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        refreshButton.layer.shadowRadius = 10
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: 150),
            refreshButton.heightAnchor.constraint(equalToConstant: 30),
            refreshButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
    }
    
    @objc func refreshTapped() {
        addCafes(location: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude))
    }
}

extension ResultsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        //updates map as user moves (very sensitive, should create a buffet for a min distance moved or else it will keep changing this region randomly)
        //        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        //        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }
    
    func configureListButton() {
        listButton = UIBarButtonItem(image: Icons.listIcon, style: .plain, target: self, action: #selector(listPressed))
        navigationItem.rightBarButtonItem = listButton
        listButton.tintColor = .white
    }
    
    @objc func listPressed() {
        let listResultsVC = ListResultsVC()
        listResultsVC.cafeList = totalCafeList
        listResultsVC.configure()
        navigationController?.pushViewController(listResultsVC, animated: true)
    }
    
    
}

extension ResultsVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let newLocation = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        refreshButton.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let cluster = annotation as? MKClusterAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "cluster")
            }
            
            annotationView?.tintColor = .brown
            annotationView?.annotation = cluster
            return annotationView
            
        }
        
        if let placeAnnotation = annotation as? CafeOnMap {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Cafe") as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Cafe")
                annotationView?.canShowCallout = true
                annotationView?.clusteringIdentifier = "cluster"
            } else {
                annotationView?.annotation = annotation
            }
            
            
            return annotationView
            
        }
        
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let cafeAnnotation = view.annotation as? CafeOnMap {
            cardView.set(cafe: cafeAnnotation.cafe)
        }
    }
    
    
}
