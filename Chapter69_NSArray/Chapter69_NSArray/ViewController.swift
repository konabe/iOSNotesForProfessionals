//
//  ViewController.swift
//  Chapter69_NSArray
//
//  Created by 小鍋涼太 on 2021/10/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §69.1 Convert Array into json string"
        let array = [["one": 1], ["two": 2], ["three": 3], ["four": 4]]
        let jsonString = convertIntoJsonString(arrayObject: array)
        print("json - \(jsonString)")
    }
    
    func convertIntoJsonString(arrayObject: [Any]) -> String? {
        do {
            let jsonData: Data = try! JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        }
        return nil
    }

}

