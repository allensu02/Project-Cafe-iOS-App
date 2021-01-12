//
//  PCCategoryCell.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class PCCategoryCell: UITableViewCell {

    var category: Category!
    var containerView: UIView!
    var iconView: UIImageView!
    var lineIcon: UIImageView!
    var catLabel: PCTitleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
        print("awoke")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    init (style: UITableViewCell.CellStyle, reuseIdentifier: String?, category: Category) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.category = category
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureContainerView()
        configureIcon()
        configureLineIcon()
        configureLabel()
        print("ran config")
        
        
    }
    
    func configureContainerView() {
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        containerView.layer.cornerRadius = 5
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = Colors.defaultBrown.cgColor
    }
    
    func configureIcon() {
        print("ran config icon")
        iconView = UIImageView()
       
        iconView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(iconView)
        print("ran config icon x2")

        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 30),
            iconView.widthAnchor.constraint(equalToConstant: 30)
        ])
        iconView.tintColor = Colors.defaultBrown
        switch category {
        case .drinkCoffee:
            iconView.image = Icons.coffeeIcon
            return
        case .work:
            iconView.image = Icons.computerIcon
            return
        case .groupMeal:
            iconView.image = Icons.groupIcon
            return
        case .relax:
            iconView.image = Icons.relaxIcon
            return
        default:
            iconView.image = Icons.relaxIcon
            print("default ran")
        }
    }
    
    func configureLineIcon() {
        lineIcon = UIImageView(image: Icons.horizontalLines)
        lineIcon.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lineIcon)

        NSLayoutConstraint.activate([
            lineIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lineIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
            lineIcon.heightAnchor.constraint(equalToConstant: 30),
            lineIcon.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureLabel() {
        catLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        category = .drinkCoffee
        catLabel.font = .systemFont(ofSize: 20, weight: .black)
        catLabel.text = category.rawValue
        containerView.addSubview(catLabel)
    
        NSLayoutConstraint.activate([
            catLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            catLabel.heightAnchor.constraint(equalToConstant: 40),
            catLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            catLabel.trailingAnchor.constraint(equalTo: lineIcon.leadingAnchor, constant: -20)
        ])
    }

}
