//
//  PCLabelSearchView.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/29.
//

import UIKit

class PCLabelSearchView: UIView {

    var label: PCTitleLabel!
    //var searchBar: UISearchBar!
    var mapButton: UIButton!
    var resultSearchController: UISearchController? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configureLabel()
        configureMapButton()
        //configureSearchBar()
        configureSearchController()
    }
    
    func configureLabel() {
        label = PCTitleLabel(textAlignment: .left, fontSize: 30)
        label.text = "搜尋範圍"
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureMapButton() {
        mapButton = UIButton()
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        let img = Icons.mapPinLogoIcon.withTintColor(Colors.navyBlue)
        mapButton.setImage(img, for: .normal)
        addSubview(mapButton)
        
        NSLayoutConstraint.activate([
            mapButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            mapButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapButton.heightAnchor.constraint(equalToConstant: 40),
            mapButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
//    func configureSearchBar() {
//        searchBar = UISearchBar()
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchBar.placeholder = "搜尋城市、捷運站、地區"
//        searchBar.backgroundImage = UIImage()
//        addSubview(searchBar)
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
//            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: mapButton.leadingAnchor, constant: -10),
//            searchBar.heightAnchor.constraint(equalToConstant: 40)
//        ])
//    }
    
    func configureSearchController() {
        let locationSearchTable = LocationResultsTVC()
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        searchBar.backgroundColor = .cyan
        //addSubview(searchBar)
//        searchBar.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
//            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
//            searchBar.trailingAnchor.constraint(equalTo: mapButton.leadingAnchor, constant: -10),
//            searchBar.heightAnchor.constraint(equalToConstant: 40)
//        ])
        locationSearchTable.tableView.tableHeaderView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
    }

}
