//
//  ViewController.swift
//  Chapter97_CLLocation
//
//  Created by 小鍋涼太 on 2021/10/11.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        CLLocationManager().requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            print("I'm in WhenInUse!")
            // §97.1 Distance Filter using
            // 最高精度
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 5メートル以内の変更は検知しない
            locationManager.distanceFilter = 5
            
            // §97.2 Get User Location Using CLLocationManager
            
        }
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("didChangeAuthorization called. \(manager.authorizationStatus.rawValue)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location updated!")
    }
}
