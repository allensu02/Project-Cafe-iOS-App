//
//  PCIndividualTopView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/2/5.
//

import UIKit

class PCIndividualTopView: UIView {

    var imageView: UIImageView!
    var nameLabel: PCTitleLabel!
    var scrollView: UIScrollView!
    var cafe: Cafe!
    var containerView: UIStackView!
    var currentOffset = 10
    var activeFilters: [PCFilterButton] = []
    var mapButton: PCButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(cafe: Cafe) {
        super.init(frame: .zero)
        self.cafe = cafe
        backgroundColor = .systemBackground
        configure()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure() {
        configureImageView()
        configureNameLabel()
        configureFilterScrollView()
        configureMapButton()
    }

    func configureImageView() {
        imageView = UIImageView()
        imageView.image = Images.cafePlaceholderImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170)
        ])
        
        guard let urlList = cafe.photos else { return }
        if (urlList.count == 0) {
            return
        }
        guard let url = URL(string: urlList[0]) else { return }
        downloadImage(from: url)
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self!.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func configureNameLabel() {
        nameLabel = PCTitleLabel(textAlignment: .left, fontSize: 30)
        nameLabel.text = cafe.name

        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func configureFilterScrollView() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView = UIStackView(frame: CGRect(x: 0, y: 5, width: 1000, height: 40))
        configureContainerView()
        scrollView.addSubview(containerView)
        scrollView.contentSize = CGSize(width: currentOffset, height: 40)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            scrollView.heightAnchor.constraint(equalToConstant: 50),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        scrollView.contentSize = CGSize(width: currentOffset, height: 40)
        containerView.reloadInputViews()
    }
    
    func configureMapButton() {
        mapButton = PCButton(backgroundColor: .systemGray4, title: "看地圖")
        mapButton.setTitleColor(.black, for: .normal)
        
        addSubview(mapButton)
        
        NSLayoutConstraint.activate([
            mapButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5),
            mapButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mapButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mapButton.heightAnchor.constraint(equalToConstant: 40)
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
            activeFilters.append(PCFilterButton(iconImage: Icons.cupFilled, filter: .goodCoffee))
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
            activeFilters.append(PCFilterButton(iconImage: Icons.dessertFilled, filter: .desserts))
        }
        if (cafe.meals   != nil && cafe.timeLimit!) {
            activeFilters.append(PCFilterButton(iconImage: Icons.foodIcon, filter: .meals))
        }
    }
}
