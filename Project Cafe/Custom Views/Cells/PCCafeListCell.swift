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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cafe: Cafe) {
        self.cafe = cafe
        configureCardView()
        cardView.setAttributes()
        backgroundColor = .systemGray4
    }
    
    func configureCardView() {
        cardView = PCCafeCardView(cafe: cafe)
        contentView.addSubview(cardView)
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: Numbers.cardViewHeight)
        ])
        
    }
}
