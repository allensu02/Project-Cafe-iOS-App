//
//  MapVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/19.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    var pinView: UIImageView!
    let regionInMeters: Double = 1000
    var previousLocation: CLLocation!
    var initialLocation: CLLocation!
    var label: UILabel!
    var confirmButton: PCButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMapView()
        configureImageView()
        configureConfirmButton()
        configureLabel()
        checkLocationServices()
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        mapView.delegate = self
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureImageView() {
        pinView = UIImageView()
        pinView.translatesAutoresizingMaskIntoConstraints = false
        pinView.image = Icons.mapPinIcon
        pinView.contentMode = .scaleAspectFit
        view.addSubview(pinView)
        NSLayoutConstraint.activate([
            pinView.heightAnchor.constraint(equalToConstant: 40),
            pinView.widthAnchor.constraint(equalToConstant: 40),
            pinView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20)
        ])
    }
    
    func configureConfirmButton() {
        confirmButton = PCButton(backgroundColor: Colors.lightBrown, title: "確定範圍")
        confirmButton.setTitleColor(Colors.navyBlue, for: .normal)
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
    }
    
    @objc func confirmTapped () {
        print(label.text)
        if (label.text == nil || label.text == "" || label.text == " ") {
            print("error w label")
            presentPCAlertOnMainThread(title: "無地址顯示", message: "您搜尋的地點沒有顯示出地址。請移動地圖至有地址的位置 🗺", buttonTitle: "知道了")
            return
        }
        guard let prevVC =  navigationController?.viewControllers[(navigationController?.viewControllers.count)!-2] as? FilterVC else {
            print("problem with confirmed tap")
            return
        }
        print("ran confirmedtap")
        prevVC.locationToSearch = getCenterLocation(for: mapView)
        
        prevVC.searchBarView.searchBar.searchTextField.text = label.text
        navigationController?.popViewController(animated: true)
        print("ran dismissed")
    }
    func configureLabel() {
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: confirmButton.topAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func centerViewOnInitialLocation() {
        
        let region = MKCoordinateRegion.init(center: initialLocation.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
        
    }
    
    //if location services is enabled, set up location manager and checks location auth. starts updating location
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            print("enable location services on settings")
        }
    }
    
    //configure location manager
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
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
            print("you gotta go change this in settings")
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            initialLocation = locationManager.location
            startTrackingUserLocation()
            break
        }
    }
    
    func startTrackingUserLocation () {
        print("ran startrack")
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    //updates the region based on the location
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            
            mapView.setRegion(region, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = Colors.navyBlue
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "請選定要搜尋的範圍"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension MapVC: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        
        guard let previousLocation = self.previousLocation else {
            print("prev loc not valid")
            return
            
        }
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                print("error w geocode")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("error w placemark")
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.label.text = "\(streetNumber) \(streetName)"
            }
        }
    }
    
}
