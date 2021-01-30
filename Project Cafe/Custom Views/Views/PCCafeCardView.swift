//
//  PCCafeCardView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/26.
//

import UIKit

class PCCafeCardView: UIView {

    var cafe: Cafe!
    var imageView: UIImageView!
    var nameLabel: PCTitleLabel!
    var openTimeLabel: PCTitleLabel!
    var distanceLabel: PCTitleLabel!
    var activeFilters: [PCFilterButton] = []
    var scrollView: UIScrollView!
    var containerView: UIStackView!
    var currentOffset = 10
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(cafe: Cafe) {
        super.init(frame: .zero)
        self.cafe = cafe
        configure()
    }
    
    func set(cafe: Cafe) {
        self.cafe = cafe
        clearAttributes()
        setAttributes()
        
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        clipsToBounds = true
        backgroundColor = .white
        configureImageView()
        configureNameLabel()
        configureOpenTimeLabel()
        configureDistanceLabel()
        configureFilterScrollView()
    }
    
    func clearAttributes() {
        imageView.image = nil
        nameLabel.text = ""
        openTimeLabel.text = ""
        distanceLabel.text = ""
        for button in containerView.subviews {
            button.removeFromSuperview()
        }
        currentOffset = 10
        activeFilters = []
    }
    
    func setAttributes () {
        imageView.image = Images.cafePlaceholderImage
        nameLabel.text = cafe.name
        openTimeLabel.text = "operating hours"
        distanceLabel.text = "Distance: \(cafe.distance!)"
        configureContainerView()
        scrollView.contentSize = CGSize(width: currentOffset, height: 40)
        containerView.reloadInputViews()
        
    }
    
    func configureImageView() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    func configureNameLabel() {
        nameLabel = PCTitleLabel(textAlignment: .left, fontSize: 25)
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureOpenTimeLabel() {
        openTimeLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        addSubview(openTimeLabel)
        
        NSLayoutConstraint.activate([
            openTimeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            openTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            openTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            openTimeLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configureDistanceLabel() {
        distanceLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        addSubview(distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: openTimeLabel.bottomAnchor, constant: 5),
            distanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            distanceLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configureFilterScrollView() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        containerView = UIStackView(frame: CGRect(x: 0, y: 5, width: 1000, height: 40))
        configureContainerView()
        scrollView.addSubview(containerView)
        scrollView.contentSize = CGSize(width: currentOffset, height: 40)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 5),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
    }
    
    func configureContainerView() {
        configureFilters()
        for filter in activeFilters {
            filter.addColor()
            filter.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(filter)
            NSLayoutConstraint.activate([
                filter.heightAnchor.constraint(equalToConstant: 40),
                filter.widthAnchor.constraint(equalToConstant: 150),
                filter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: CGFloat(currentOffset)),
                filter.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
            currentOffset += 160
        }
    }
    
    func configureFilters() {
        //check with garcia on meaning of this bool
        guard let cafe = cafe else {
            print("not valid cafe")
            return
        }
        if (cafe.timeLimit != nil && cafe.timeLimit!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.clockIcon, filter: .noLimit))
        }
        if (cafe.plugs != nil && cafe.plugs!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.outletIcon, filter: .outlets))
        }
        //need to figure out open now bool
//        if (cafe. != nil && cafe.timeLimit!) {
//            activeFilters.append(.noLimit)
//        }
        if (cafe.pourOver != nil && cafe.pourOver!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.coffeeIcon, filter: .goodCoffee))
        }
        if (cafe.nearMrt != nil && cafe.nearMrt!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.mrtIcon, filter: .mrt))
        }
        if (cafe.wifi != nil && cafe.wifi!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.wifiIcon, filter: .wifi))
        }
        if (cafe.seats != nil && cafe.seats! > 2) {
            activeFilters.append(PCFilterButton(iconImage: Icons.seatsIcon, filter: .seats))
        }
        if (cafe.quietness != nil && cafe.quietness! > 2) {
            activeFilters.append(PCFilterButton(iconImage: Icons.quietIcon, filter: .quiet))
        }
        //need to separately deal with price
//        if (cafe.priceLevel != nil && cafe.timeLimit!) {
//            activeFilters.append(.noLimit)
//        }
        if (cafe.desserts != nil && cafe.desserts!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.dessertIcon, filter: .desserts))
        }
        if (cafe.meals   != nil && cafe.timeLimit!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.foodIcon, filter: .meals))
        }
    }

}

extension PCCafeCardView: UIScrollViewDelegate {
    
}
