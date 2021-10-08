//
//  ViewController.swift
//  Chapter79_NSURL
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §79.1 How to get last string component from NSURL String
        // §79.2 How to get last string components from URL in Swift
        print(URL(string: "https://example.com/index.txt")?.lastPathComponent)
        
    }


}

