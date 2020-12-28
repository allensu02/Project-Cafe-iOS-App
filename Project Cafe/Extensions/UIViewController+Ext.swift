//
//  UIViewController+Ext.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/24.
//

import UIKit

extension UIViewController {
    func presentPCAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = PCAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
