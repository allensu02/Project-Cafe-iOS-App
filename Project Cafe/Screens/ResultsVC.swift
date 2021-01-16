//
//  ResultsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit
import MapKit


class ResultsVC: UISearchController {
    
    var refreshButton: UIButton!
    var tempLabel: PCTitleLabel!
    let locationManager = CLLocationManager()
    var mapView: MKMapView!
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation!
    var initialLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        configureUI()
        addCafes(location: initialLocation)
    }
    
    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        configureMap()
        configureRefreshButton()
    }
    
    func addCafes(location: CLLocation) {
        print("ran add cafes")
        NetworkManager.shared.getCafes(lat: location.coordinate.latitude, lon: location.coordinate.longitude, limit: 15) { (data) in
            print("running in closure")
            let cafeList = data.results
            var cafeAnnotations: [CafeOnMap] = []
            for cafe in cafeList {
                let testCafe = CafeOnMap(cafe: cafe)
                cafeAnnotations.append(testCafe)
            }
            DispatchQueue.main.async {
                self.mapView.addAnnotations(cafeAnnotations)
                self.refreshButton.isHidden = true
                print("updated annotations")
            }
        }
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
            initialLocation = locationManager.location
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
    
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        var latitude = mapView.centerCoordinate.latitude
        var longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
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
        refreshButton.setTitle("Refresh", for: .normal)
        refreshButton.setTitleColor(.black, for: .normal)
        refreshButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .black)
        view.addSubview(refreshButton)
        
        NSLayoutConstraint.activate([
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            refreshButton.widthAnchor.constraint(equalToConstant: 150),
            refreshButton.heightAnchor.constraint(equalToConstant: 40),
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
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "InterestingPlace") as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "InterestingPlace")
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
        print(view.annotation?.title)
    }
    
    
}
