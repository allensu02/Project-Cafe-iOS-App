//
//  PCLabelSearchView.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/29.
//

import UIKit

class PCLabelSearchView: UIView {

    var label: PCTitleLabel!
    var searchBar: UISearchBar!
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
        configureSearchBar()
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
    
    func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "搜尋城市、捷運站、地區"
        searchBar.layer.borderWidth = 0
        searchBar.layer.borderColor = Colors.defaultBrown.cgColor
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    

}
