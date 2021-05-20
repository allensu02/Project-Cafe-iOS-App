//
//  LocationResultsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/4/22.
//

import UIKit
import MapKit

class LocationResultsVC: UIViewController {

    var tableView: UITableView!
    var searchBar: UISearchBar!
    var locationResults: [MKLocalSearchCompletion] = []

    private let completer = MKLocalSearchCompleter()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "hello?"
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        configureCompleter()
        configureSearchBar()
        configureTableView()
    }
    
    func configureCompleter() {
        completer.delegate = self
        completer.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.763081283843682, longitude: 120.99124358282349), latitudinalMeters: 100000, longitudinalMeters: 100000)
    }
    
    func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "搜尋城市、捷運站、地區"
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = Colors.navyBlue.cgColor
        searchBar.backgroundImage = UIImage()

        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myIdentifier")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}
extension LocationResultsVC: UISearchTextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let query = textField.text else {
            if completer.isSearching {
                completer.cancel()
            }
            return
        }
        completer.queryFragment = query
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

    }
}

extension LocationResultsVC: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        for result in completer.results {
            print(result.description)
            locationResults.append(result)
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension LocationResultsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myIdentifier", for: indexPath)
        cell.textLabel?.text = locationResults[indexPath.row].title
        return cell
    }
    
    
}
