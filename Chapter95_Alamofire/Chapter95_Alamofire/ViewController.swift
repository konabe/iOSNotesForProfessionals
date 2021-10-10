//
//  ViewController.swift
//  Chapter95_Alamofire
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §95.1 Manual Validation
        AF.request(URL(string: "https://httpbin.org/get")!, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { result in
                print("95.1 \(result.response?.statusCode)")
            }
        
        // §95.2 Automatic Validation
        // §95.4 Making a Request
        AF.request(URL(string: "https://httpbin.org/get")!, method: .get)
            .validate()
            .responseJSON { result in
                print("95.2 \(result.response?.statusCode)")
            }
            // §95.3 Chained Response Handlers
            // §95.5 Response Handling
            .responseString { string in
                print("95.3 \(string.value)")
            }
            // §95.6 Response Handler
            .response { result in
                print(result.data)
            }
    }


}

