//
//  PCAnnotationView.swift
//  Project Cafe
//
//  Created by Allen Su on 2021/3/15.
//

import UIKit
import MapKit

class PCAnnotationView: MKMarkerAnnotationView {
    
    override var annotation: MKAnnotation? {
        willSet {
            displayPriority = MKFeatureDisplayPriority.required
        }
    }
    
}
