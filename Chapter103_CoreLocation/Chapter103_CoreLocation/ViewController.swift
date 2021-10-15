//
//  ViewController.swift
//  Chapter103_CoreLocation
//
//  Created by 小鍋涼太 on 2021/10/15.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §103.1 Request Permission to Use Location Services
        let manager = CLLocationManager()
        let status = manager.authorizationStatus
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .restricted:
            print("restricted")
        @unknown default:
            fatalError()
        }
        manager.requestWhenInUseAuthorization()
        
        // §103.2 Florida.gpx にて
        // Edit SchemeからDefault Locationを設定できる
        
        // §103.4 Location Services in the Background
        // Capabilities から Background Modeを追加して、Locaiton updatesにチェック
        manager.allowsBackgroundLocationUpdates = true
        manager.startUpdatingLocation()
    }


}

