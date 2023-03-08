//
//  MyLocation.swift
//  MeteoApp
//
//  Created by Тимур Мурадов on 11.08.2022.
//

import Foundation
import UIKit
import CoreLocation

class locationVC: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Локация"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.delegate = nil
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.headingFilter = 5.0
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func StartUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func StopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        
    }
    
}
