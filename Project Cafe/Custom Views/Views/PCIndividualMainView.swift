//
//  PCIndividualMainView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/2/5.
//

import UIKit

class PCIndividualMainView: UIView {

    var cafe: Cafe!
    var infoLabel: PCTitleLabel!
    var distanceView: UIImageView!
    var distanceLabel: PCTitleLabel!
    var openView: UIImageView!
    var openLabel: PCTitleLabel!
    var openButton: UIButton!
    var pinView: UIImageView!
    var pinLabel: PCTitleLabel!
    var globeView: UIImageView!
    var globeLabel: PCTitleLabel!
    var mrtView: UIImageView!
    var mrtLabel: PCTitleLabel!
    
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
        configureInfoLabel()
        configureDistance()
        configureOpenNow()
        configureLocation()
        configureWebsite()
        configureMrt()
    }
    
    func configureInfoLabel() {
        infoLabel = PCTitleLabel(textAlignment: .left, fontSize: 20)
        infoLabel.text = "基本資料"
        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            infoLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func configureDistance() {
        distanceView = UIImageView(image: Icons.walkIcon)
        distanceView.translatesAutoresizingMaskIntoConstraints = false
        distanceView.tintColor = .black
        distanceLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        guard let distance = cafe.distance else { return }
        distanceLabel.text = "\(distance) 公尺"
        
        addSubviews(distanceView, distanceLabel)
        
        NSLayoutConstraint.activate([
            distanceView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 10),
            distanceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            distanceView.widthAnchor.constraint(equalToConstant: 20),
            distanceView.heightAnchor.constraint(equalToConstant: 20),
            
            distanceLabel.leadingAnchor.constraint(equalTo: distanceView.trailingAnchor, constant: 10),
            distanceLabel.topAnchor.constraint(equalTo: distanceView.topAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            distanceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureOpenNow() {
        openView = UIImageView(image: Icons.clockIcon)
        openView.translatesAutoresizingMaskIntoConstraints = false
        openView.tintColor = .black
        openLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        openLabel.text = "fuck this one"
        
        addSubviews(openView, openLabel)
        
        NSLayoutConstraint.activate([
            openView.topAnchor.constraint(equalTo: distanceView.bottomAnchor, constant: 10),
            openView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            openView.widthAnchor.constraint(equalToConstant: 20),
            openView.heightAnchor.constraint(equalToConstant: 20),
            
            openLabel.leadingAnchor.constraint(equalTo: openView.trailingAnchor, constant: 10),
            openLabel.topAnchor.constraint(equalTo: openView.topAnchor),
            openLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            openLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureLocation() {
        pinView = UIImageView(image: Icons.mapPinLogoIcon)
        pinView.tintColor = .black
        pinView.translatesAutoresizingMaskIntoConstraints = false
        
        pinLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        guard let address = cafe.address else { return }
        pinLabel.text = "\(address)"
        
        addSubviews(pinView, pinLabel)
        
        NSLayoutConstraint.activate([
            pinView.topAnchor.constraint(equalTo: openLabel.bottomAnchor, constant: 10),
            pinView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            pinView.widthAnchor.constraint(equalToConstant: 20),
            pinView.heightAnchor.constraint(equalToConstant: 20),
            
            pinLabel.leadingAnchor.constraint(equalTo: pinView.trailingAnchor, constant: 10),
            pinLabel.topAnchor.constraint(equalTo: pinView.topAnchor),
            pinLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            pinLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureWebsite() {
        globeView = UIImageView(image: Icons.globeIcon)
        globeView.tintColor = .black
        globeView.translatesAutoresizingMaskIntoConstraints = false
        
        globeLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        guard let url = cafe.url else { return }
        globeLabel.text = "\(url)"
        
        addSubviews(globeView, globeLabel)
        
        NSLayoutConstraint.activate([
            globeView.topAnchor.constraint(equalTo: pinLabel.bottomAnchor, constant: 10),
            globeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            globeView.widthAnchor.constraint(equalToConstant: 20),
            globeView.heightAnchor.constraint(equalToConstant: 20),
            
            globeLabel.leadingAnchor.constraint(equalTo: globeView.trailingAnchor, constant: 10),
            globeLabel.topAnchor.constraint(equalTo: globeView.topAnchor),
            globeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            globeLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureMrt() {
        mrtView = UIImageView(image: Icons.mrtIcon)
        mrtView.tintColor = .black
        mrtView.translatesAutoresizingMaskIntoConstraints = false
        
        mrtLabel = PCTitleLabel(textAlignment: .left, fontSize: 15)
        guard let mrt = cafe.mrtStation else { return }
        mrtLabel.text = (cafe.mrtStation)
        
        addSubviews(mrtView, mrtLabel)
        
        NSLayoutConstraint.activate([
            mrtView.topAnchor.constraint(equalTo: globeView.bottomAnchor, constant: 10),
            mrtView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mrtView.widthAnchor.constraint(equalToConstant: 20),
            mrtView.heightAnchor.constraint(equalToConstant: 20),
            
            mrtLabel.leadingAnchor.constraint(equalTo: mrtView.trailingAnchor, constant: 10),
            mrtLabel.topAnchor.constraint(equalTo: mrtView.topAnchor),
            mrtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mrtLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
