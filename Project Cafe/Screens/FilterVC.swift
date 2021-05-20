//
//  FilterStringsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit
import MapKit

class FilterVC: UIViewController {
    
    var searchBarView: PCLabelSearchView!
    var stackView: UIStackView!
    var categorySectionView: PCSectionView!
    var filterSectionView: PCSectionView!
    var findButton: PCButton!
    var currentCategory: PCCategoryButton!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var filterHeightAnchor: NSLayoutConstraint!
    var locationManager: CLLocationManager!
    var locationToSearch: CLLocation!
    var resultsTableView: UITableView!
    var locationResults: [MKLocalSearchCompletion] = []
    var queryString: String = ""
    var resultSearchController: UISearchController? = nil
    
    private let completer = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCompleter()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
            
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        title = "偏好篩選"
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        currentCategory = nil
        configureScrollView()
        configureSearchBar()
        configureCategoryView()
        configureFilterView()
        configureFindButton()
        //configureSearchController()
    }
    
    func configureSearchController() {
        let locationSearchTable = LocationResultsTVC()
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    func configureCompleter() {
        completer.delegate = self
        completer.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.763081283843682, longitude: 120.99124358282349), latitudinalMeters: 100000, longitudinalMeters: 100000)
    }
    
    func configureScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func configureSearchBar() {
        searchBarView = PCLabelSearchView()
        
        //searchBarView.searchBar.isUserInteractionEnabled = true
        contentView.addSubview(searchBarView)
        searchBarView.mapButton.addTarget(self, action: #selector(mapButtonTapped), for: .touchUpInside)
        //searchBarView.searchBar.searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            searchBarView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    @objc func mapButtonTapped() {
        navigationController?.pushViewController(MapVC(), animated: true)
    }
    
    func configureCategoryView() {
        categorySectionView = PCSectionView(titleText: "類別")
        contentView.addSubview(categorySectionView)
        NSLayoutConstraint.activate([
            categorySectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
            categorySectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            categorySectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            categorySectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        for button in categorySectionView.categoryButtons {
            button.addTarget(self, action: #selector(categorySelected) , for: .touchUpInside)
        }
        categorySectionView.editButton.addTarget(self, action: #selector(categoryEdit), for: .touchUpInside)
        //hide button
        categorySectionView.editButton.isHidden = true
        categorySectionView.moreButton.addTarget(self, action: #selector(categoryMore), for: .touchUpInside)
        categorySectionView.moreButton.isHidden = true
    }
    
    @objc func categorySelected(sender: PCCategoryButton!) {
        resetButtons()
        sender.addColor()
        sender.isTapped = true
        currentCategory = sender
        for button in filterSectionView.filterButtons {
            if currentCategory.filterList.contains(button.filter!) {
                button.addColor()
                button.isTapped = true
            }
        }
        
    }
    
    @objc func categoryEdit() {
        //should change to edit later
        let editCategoryVC = EditCategoryVC()
        navigationController?.pushViewController(editCategoryVC, animated: true)
        
    }
    
    @objc func categoryMore() {
        print("cat more selected")
    }
    
    
    func configureFilterView() {
        filterSectionView = PCSectionView(titleText: "條件")
        contentView.addSubview(filterSectionView)
        filterHeightAnchor = filterSectionView.heightAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([
            filterSectionView.topAnchor.constraint(equalTo: categorySectionView.bottomAnchor, constant: 10),
            filterSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filterSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            filterHeightAnchor
        ])
        filterSectionView.filterButtons[10].addTarget(self, action: #selector(openTimeSelected), for: .touchUpInside)
        filterSectionView.filterButtons[6].addTarget(self, action: #selector(priceSelected), for: .touchUpInside)
        for button in filterSectionView.filterButtons {
            button.addTarget(self, action: #selector(FilterSelected), for: .touchUpInside)
        }
        
        filterSectionView.editButton.isHidden = true
        filterSectionView.moreButton.bringSubviewToFront(view)
        filterSectionView.moreButton.addTarget(self, action: #selector(filterMore), for: .touchUpInside)
        
    }

    @objc func openTimeSelected (sender: PCFilterButton!) {
        if (!sender.isTapped) {
            presentPopUp(vc: PCOpeningHoursVC())
        } else {
            return
        }
    }
    
    @objc func priceSelected(sender: PCFilterButton!) {
        if (!sender.isTapped) {
            presentPopUp(vc: PCPriceVC())
        } else {
            return
        }
        
    }
    
    @objc func FilterSelected(sender: PCFilterButton!) {
        
        if (sender.isTapped) {
            sender.removeColor()
            sender.isTapped = false
            var allFalse = true
            for button in filterSectionView.filterButtons {
                if (sender.isTapped) {
                    allFalse = false
                }
                if (allFalse) {
                    for button in categorySectionView.categoryButtons {
                        button.removeColor()
                        button.isTapped = false
                    }
                }
            }
        } else {
            sender.addColor()
            sender.isTapped = true
        }
        
        
    }
    
    @objc func filterMore() {
        filterSectionView.expandFilter()
        filterHeightAnchor.constant = 430
        //filterSectionView.hideButton.addTarget(self, action: #selector(hideTapped), for: .touchUpInside)
        
    }
    
    @objc func hideTapped() {
        filterSectionView.reduce()
    }
    
    func resetButtons() {
        for button in filterSectionView.filterButtons {
            button.removeColor()
            button.isTapped = false
        }
        
        for button in categorySectionView.categoryButtons {
            button.removeColor()
            button.isTapped = false
        }
    }
    
    func configureFindButton() {
        findButton = PCButton(backgroundColor: Colors.lightBrown, title: "找咖啡廳！")
        findButton.setTitleColor(Colors.navyBlue, for: .normal)
        contentView.addSubview(findButton)
        NSLayoutConstraint.activate([
            findButton.topAnchor.constraint(equalTo: filterSectionView.bottomAnchor, constant: 20),
            findButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            findButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            findButton.heightAnchor.constraint(equalToConstant: 40),
            findButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        findButton.addTarget(self, action: #selector(findTapped), for: .touchUpInside)
    }
    
    @objc func findTapped() {
//        if (searchBarView.searchBar.text == "") {
//            presentPCAlertOnMainThread(title: "未輸入地址!", message: "請輸入您想搜尋的範圍. 我們想幫您找到最適合您的咖啡廳! ☕", buttonTitle: "知道了")
//        } else {
//            let resultsVC = ResultsVC()
//            locationManager = CLLocationManager()
//            resultsVC.initialLocation = locationToSearch
//            configureQueryString()
//            resultsVC.queryString = queryString
//            navigationController?.pushViewController(resultsVC, animated: true)
//        }
    }
    
    func configureQueryString() {
        for filterButton in filterSectionView.filterButtons {
            if filterButton.isTapped {
                switch filterButton.filter {
                case .noLimit: queryString = queryString + "&time_limit=false"
                case .outlets: queryString = queryString + "&plugs=true"
                case .openNow: queryString = queryString + "&open_now=true"
                case .goodCoffee: queryString = queryString + "&pour_over=true"
                case .mrt: queryString = queryString + "&near_mrt=true"
                case .wifi: queryString = queryString + "&wifi=true"
                case .noLimit: queryString = queryString + "&wifi=true"
                case .seats: queryString = queryString + "&seats_min=3"
                case .quiet: queryString = queryString + "&quietness_min=3"
                case .price: queryString = queryString + "&price_level_max=1"
                //need to update open time filter
                case .price: queryString = queryString + "&price_level_max=1"
                case .desserts: queryString = queryString + "&desserts=true"
                case .meals: queryString = queryString + "&meals=true"
                default: break
                }
            }
        }
        print(queryString)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension FilterVC: UISearchTextFieldDelegate{
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        guard let query = textField.text else {
//            if completer.isSearching {
//                completer.cancel()
//            }
//            return
//        }
//        completer.queryFragment = query
//        DispatchQueue.main.async {
//            self.resultsTableView.reloadData()
//        }
//
//    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        let locationResultsSC = LocationResultsSearchController()
//        navigationController?.pushViewController(locationResultsSC, animated: true)
        return false
    }
}

extension FilterVC: MKLocalSearchCompleterDelegate {
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

extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myIdentifier", for: indexPath)
        cell.textLabel?.text = locationResults[indexPath.row].title
        return cell
    }
    
    
}
