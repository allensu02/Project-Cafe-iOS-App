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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "偏好篩選"
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        currentCategory = nil
        configureScrollView()
        configureSearchBar()
        configureCategoryView()
        configureFilterView()
        configureFindButton()
        
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
        contentView.addSubview(searchBarView)
        
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            searchBarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            searchBarView.heightAnchor.constraint(equalToConstant: 90)
        ])
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
        categorySectionView.moreButton.addTarget(self, action: #selector(categoryMore), for: .touchUpInside)
        categorySectionView.moreButton.isHidden = true
    }
    
    @objc func categorySelected(sender: PCCategoryButton!) {
        resetButtons()
        sender.addColor()
        
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
        
        for button in filterSectionView.filterButtons {
            button.addTarget(self, action: #selector(FilterSelected), for: .touchUpInside)
        }
        filterSectionView.filterButtons[10].addTarget(self, action: #selector(openTimeSelected), for: .touchUpInside)
        filterSectionView.editButton.isHidden = true
        filterSectionView.moreButton.bringSubviewToFront(view)
        filterSectionView.moreButton.addTarget(self, action: #selector(filterMore), for: .touchUpInside)

    }
    
    @objc func openTimeSelected () {
        presentOpenTimePopUp()
    }
    
    @objc func FilterSelected(sender: PCIconButton!) {

        if (sender.isTapped) {
            sender.removeColor()
            sender.isTapped = false
            for button in categorySectionView.categoryButtons {
                button.removeColor()
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
        findButton = PCButton(backgroundColor: Colors.defaultBrown, title: "找咖啡廳！")
        contentView.addSubview(findButton)
        NSLayoutConstraint.activate([
            findButton.topAnchor.constraint(equalTo: filterSectionView.bottomAnchor, constant: 20),
            findButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            findButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            findButton.heightAnchor.constraint(equalToConstant: 40),
            findButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        findButton.addTarget(self, action: #selector(findTapped), for: .touchUpInside)
    }
    
    @objc func findTapped() {
        if (searchBarView.searchBar.text == "") {
            presentPCAlertOnMainThread(title: "Location Required", message: "Please insert a location", buttonTitle: "Ok")
        } else {
            let resultsVC = ResultsVC()
            locationManager = CLLocationManager()
            resultsVC.initialLocation = locationManager.location
            navigationController?.pushViewController(resultsVC, animated: true)
        }
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
}
