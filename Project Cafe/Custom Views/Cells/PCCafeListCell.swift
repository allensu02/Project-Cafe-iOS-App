//
//  PCCafeListCell.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/31.
//

import UIKit

class PCCafeListCell: UITableViewCell {

    var cafe: Cafe!
    var cardView: PCCafeCardView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init (style: UITableViewCell.CellStyle, reuseIdentifier: String?, cafe: Cafe) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cafe = cafe
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureCardView()
    }
    
    func configureCardView() {
        cardView = PCCafeCardView(cafe: cafe)
        addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
