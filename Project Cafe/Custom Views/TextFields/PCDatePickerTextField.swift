//
//  PCDatePickerTextField.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/1/14.
//

import UIKit

class PCDatePickerTextField: UITextField {

    var picker: UIDatePicker!
    var toolBar: UIToolbar!
    var doneButton: UIBarButtonItem!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(doneButton: UIBarButtonItem!) {
        super.init(frame: .zero)
        self.doneButton = doneButton
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureBox()
        picker = UIDatePicker()
        inputView = picker
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        
        picker.addTarget(self, action:
            #selector(datePickerValueChanged), for:
            .valueChanged)
        
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
        inputAccessoryView = toolBar
    }

    func configureBox() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2
        layer.cornerRadius = 6
        textAlignment = .center
        font = .systemFont(ofSize: 20, weight: .medium)
        layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    @objc func datePickerValueChanged() {
        text = convertDateToString(date: picker.date)
    }
    
    func convertDateToString (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "hh:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        return formatter.string(from: date)
    }
}
