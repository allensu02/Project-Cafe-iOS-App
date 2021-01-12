//
//  PCCategoryNameView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/6.
//

import UIKit

class PCCategoryNameView: UIView {

    var topLabel: PCTitleLabel!
    var placeholderEmojiSelector: UIButton!
    var nameTextField: PCTextField!
    var filterList: PCFilterListView!
    
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
        configureEmojiSelector()
        configureTextField()
    }
    
    func configureLabel() {
        topLabel = PCTitleLabel(textAlignment: .left, fontSize: 25)
        topLabel.text = "類別名稱"
        addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureEmojiSelector() {
        placeholderEmojiSelector = PCButton(backgroundColor: .systemBackground, title: "P")
        addSubview(placeholderEmojiSelector)
        
        NSLayoutConstraint.activate([
            placeholderEmojiSelector.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            placeholderEmojiSelector.leadingAnchor.constraint(equalTo: leadingAnchor),
            placeholderEmojiSelector.heightAnchor.constraint(equalToConstant: 40),
            placeholderEmojiSelector.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureTextField() {
        nameTextField = PCTextField()
        nameTextField.placeholder = "舉例: 適合工作、悠閒發呆等"
        nameTextField.textAlignment = .center
        nameTextField.font = .systemFont(ofSize: 20, weight: .black)
        addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: placeholderEmojiSelector.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
        
