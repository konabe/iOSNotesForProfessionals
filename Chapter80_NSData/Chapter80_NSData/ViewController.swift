//
//  ViewController.swift
//  Chapter80_NSData
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §80.1 Converting NSData to HEX string
        // Data型でやった場合に変えた
        let data = "test".data(using: .ascii)!
        print(data.map{String(format: "%02x", $0)}.joined())
        
        // §80.2 Creating NSData objects
        _ = try! Data(contentsOf: Bundle.main.url(forResource: "free", withExtension: "png")!)
        let hinemosuData = "hinemosu".data(using: .utf8)
        
        // §80.3 Converting NSData to other types
        let hinemosuString = String(data: hinemosuData!, encoding: .utf8)
        print(hinemosuString)
        
    }


}

