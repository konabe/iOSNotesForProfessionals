//
//  ViewController.swift
//  Chapter94_Localization
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §94.1 Localization in iOS
        // Localizable.stringsを用意
        print(NSLocalizedString("str", comment: "language"))
    }


}

