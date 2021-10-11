//
//  ViewController.swift
//  Chapter98_CheckingIOSVersion
//
//  Created by 小鍋涼太 on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §98.1 iOS8 and later
        let minimumVersion = OperatingSystemVersion(majorVersion: 8, minorVersion: 1, patchVersion: 2)
        if ProcessInfo().isOperatingSystemAtLeast(minimumVersion) {
            print("supported OS!")
        }
        
        // §98.2 Swift 2.0 and later
        if #available(iOS 14, *) {
            print("your OS is larger than and equal 14")
        }
        if #available(iOS 16, *) {
        } else {
            print("your OS is less than 16")
        }
        
        // §98.3 Compare versions
        let minimumVersionString = "3.1.3"
        // §98.4 Device iOS Version
        let versionComparison = UIDevice.current.systemVersion.compare(minimumVersionString, options: .numeric)
        switch versionComparison {
        case .orderedSame, .orderedDescending:
            print("upper")
        case .orderedAscending:
            print("lower")
        }
        
        // §98.4 Device iOS Version
    }


}

