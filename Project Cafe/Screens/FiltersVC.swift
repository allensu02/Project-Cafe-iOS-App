//
//  FilterStringsVC.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/22.
//

import UIKit

class FilterVC: UIViewController {

    var searchBarView: PCLabelSearchView!
    var stackView: UIStackView!
    var categorySectionView: PCSectionView!
    var filterSectionView: PCSectionView!
    var findButton: PCButton!
    var currentCategory: PCIconButton!
    var scrollView: UIScrollView!
    var contentView: UIView!
    
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
            categorySectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        for button in categorySectionView.iconButtons {
            button.addTarget(self, action: #selector(categorySelected) , for: .touchUpInside)
        }
        categorySectionView.editButton.addTarget(self, action: #selector(categoryEdit), for: .touchUpInside)
        categorySectionView.moreButton.addTarget(self, action: #selector(categoryMore), for: .touchUpInside)
    }
    
    @objc func categorySelected(sender: PCIconButton!) {
        resetButtons()
        sender.addColor()
        currentCategory = sender
        if (currentCategory.label.text == CategoryString.work.rawValue) {
            for button in filterSectionView.iconButtons {
                if (CategoryList.work.presetFilters.contains(button.label.text!)) {
                    button.addColor()
                    button.isTapped = true
                }
            }
        }
        if (currentCategory.label.text == CategoryString.relax.rawValue) {
            for button in filterSectionView.iconButtons {
                if (CategoryList.relax.presetFilters.contains(button.label.text!)) {
                    button.addColor()
                    button.isTapped = true
                }
            }
        }
        if (currentCategory.label.text == CategoryString.groupMeal.rawValue) {
            for button in filterSectionView.iconButtons {
                if (CategoryList.groupMeal.presetFilters.contains(button.label.text!)) {
                    button.addColor()
                    button.isTapped = true
                }
            }
        }
        if (currentCategory.label.text == CategoryString.drinkCoffee.rawValue) {
            for button in filterSectionView.iconButtons {
                if (CategoryList.drinkCoffee.presetFilters.contains(button.label.text!)) {
                    button.addColor()
                    button.isTapped = true
                }
            }
        }

    }
    
    @objc func categoryEdit() {
        print("edit selected")
    }
    
    @objc func categoryMore() {
        
    }
    
    
    func configureFilterView() {
        filterSectionView = PCSectionView(titleText: "條件")
        contentView.addSubview(filterSectionView)
        NSLayoutConstraint.activate([
            filterSectionView.topAnchor.constraint(equalTo: categorySectionView.bottomAnchor, constant: 50),
            filterSectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filterSectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            filterSectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        for button in filterSectionView.iconButtons {
            button.addTarget(self, action: #selector(FilterSelected), for: .touchUpInside)
        }
        filterSectionView.editButton.addTarget(self, action: #selector(filterEdit), for: .touchUpInside)
        filterSectionView.moreButton.addTarget(self, action: #selector(filterMore), for: .touchUpInside)

    }
    
    @objc func FilterSelected(sender: PCIconButton!) {
        if (sender.isTapped) {
            sender.removeColor()
            sender.isTapped = false
            for button in categorySectionView.iconButtons {
                button.removeColor()
            }
        } else {
            sender.addColor()
            sender.isTapped = true
        }
        
        
    }
    
    @objc func filterEdit() {
        print("edit selected")
    }
    
    @objc func filterMore() {
        filterSectionView.expandView()
        print("ran filtermore")
        //updates the layout for the next run loop
        filterSectionView.setNeedsLayout()
        //updates all layouts right now
        filterSectionView.layoutIfNeeded()
    }
    
    func resetButtons() {
        for button in filterSectionView.iconButtons {
            button.removeColor()
            button.isTapped = false
        }
        
        for button in categorySectionView.iconButtons {
            button.removeColor()
            button.isTapped = false
        }
    }
    
    func configureFindButton() {
        findButton = PCButton(backgroundColor: Colors.defaultBrown, title: "找咖啡廳！")
        contentView.addSubview(findButton)
        NSLayoutConstraint.activate([
            findButton.topAnchor.constraint(equalTo: filterSectionView.bottomAnchor, constant: 50),
            findButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            findButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            findButton.heightAnchor.constraint(equalToConstant: 50),
            findButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
   
}
