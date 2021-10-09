//
//  ViewController.swift
//  Chapter84_NSBundle
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §84.1 Getting Bundle by Path
        // TODO: Bundleを作る方法がわからないので、パス
        
        // §84.2 Getting the Main Bundle
        _ = Bundle.main
        // Core Foundationを使った取得方法
        _ = CFBundleGetMainBundle()
    }


}

