//
//  UIViewController+Ext.swift
//  Project Cafe
//
//  Created by Allen Su on 2020/12/24.
//

import UIKit
import MapKit

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
    func presentPopUp(vc popUpVC: UIViewController) {
        popUpVC.modalPresentationStyle  = .overFullScreen
        popUpVC.modalTransitionStyle    = .crossDissolve
        DispatchQueue.main.async {
            self.present(popUpVC, animated: true)
        }
    }
    func compareColors (c1:UIColor, c2:UIColor) -> Bool{
        var red:CGFloat = 0
        var green:CGFloat  = 0
        var blue:CGFloat = 0
        var alpha:CGFloat  = 0
        c1.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        var red2:CGFloat = 0
        var green2:CGFloat  = 0
        var blue2:CGFloat = 0
        var alpha2:CGFloat  = 0
        c2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)

        return (Int(red*255) == Int(red*255) && Int(green*255) == Int(green2*255) && Int(blue*255) == Int(blue*255) )

    }
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        var latitude = mapView.centerCoordinate.latitude
        var longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func roundDistance(distance: Double) -> Int {
        return 10 * Int((distance / 10.0).rounded())
    }
}
