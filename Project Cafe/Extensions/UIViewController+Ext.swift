//
//  UIViewController+Ext.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/24.
//

import UIKit

extension UIViewController {
    func presentPCAlertOnMainThread(title: String, message: String, buttonTitle: String) -> PCButton {
        let alertVC = PCAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        DispatchQueue.main.async {
            self.present(alertVC, animated: true)
        }
        return alertVC.actionButton
    }
    func presentOpenTimePopUp() {
        let popUpVC = PCOpeningHoursVC()
        popUpVC.modalPresentationStyle  = .overFullScreen
        popUpVC.modalTransitionStyle    = .crossDissolve
        DispatchQueue.main.async {
            self.present(popUpVC, animated: true)
        }
    }
}
