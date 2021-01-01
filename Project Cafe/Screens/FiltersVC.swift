//
//  FiltersVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit

class FiltersVC: UIViewController {

    var searchBarView: PCLabelSearchView!
    var stackView: UIStackView!
    var categorySectionView: PCSectionView!
    var filterSectionView: PCSectionView!
    var findButton: PCButton!
    var currentCategory: PCIconButton!
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
        configureSearchBar()
        configureCategoryView()
        configureFilterView()
        configureFindButton()
    }
    
    func configureSearchBar() {
        searchBarView = PCLabelSearchView()
        view.addSubview(searchBarView)
        NSLayoutConstraint.activate([
            searchBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBarView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func configureCategoryView() {
        categorySectionView = PCSectionView(titleText: "類別")
        view.addSubview(categorySectionView)
        NSLayoutConstraint.activate([
            categorySectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
            categorySectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categorySectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categorySectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        for button in categorySectionView.iconButtons {
            button.addTarget(self, action: #selector(categorySelected) , for: .touchUpInside)
        }
        categorySectionView.editButton.addTarget(self, action: #selector(categoryEdit), for: .touchUpInside)
        categorySectionView.moreButton.addTarget(self, action: #selector(categoryMore), for: .touchUpInside)
    }
    
    @objc func categorySelected(sender: PCIconButton!) {
        sender.changeColor(otherColor: Colors.pcOrange)
        currentCategory = sender
        if (currentCategory.label.text == "專心工作") {
            filterSectionView.button1.changeColor(otherColor: Colors.defaultBrown)
            filterSectionView.button2.changeColor(otherColor: Colors.defaultBrown)
        }
    }
    
    @objc func categoryEdit() {
        print("edit selected")
    }
    
    @objc func categoryMore() {
        
    }
    func configureFilterView() {
        filterSectionView = PCSectionView(titleText: "條件")
        view.addSubview(filterSectionView)
        NSLayoutConstraint.activate([
            filterSectionView.topAnchor.constraint(equalTo: categorySectionView.bottomAnchor, constant: 50),
            filterSectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            filterSectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            filterSectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        for button in filterSectionView.iconButtons {
            button.addTarget(self, action: #selector(filterSelected), for: .touchUpInside)
        }
        filterSectionView.editButton.addTarget(self, action: #selector(filterEdit), for: .touchUpInside)
        filterSectionView.moreButton.addTarget(self, action: #selector(filterMore), for: .touchUpInside)

    }
    
    @objc func filterSelected(sender: PCIconButton!) {
        sender.changeColor(otherColor: Colors.defaultBrown)
        if (currentCategory != nil) {
            currentCategory.changeColor(otherColor: Colors.pcOrange)
            currentCategory = nil
        }
    }
    
    @objc func filterEdit() {
        print("edit selected")
    }
    
    @objc func filterMore() {
        
    }
    
    func configureFindButton() {
        findButton = PCButton(backgroundColor: Colors.defaultBrown, title: "找咖啡廳！")
        view.addSubview(findButton)
        NSLayoutConstraint.activate([
            findButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            findButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            findButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            findButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
}
