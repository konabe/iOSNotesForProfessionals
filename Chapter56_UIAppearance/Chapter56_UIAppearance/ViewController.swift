//
//  ViewController.swift
//  Chapter56_UIAppearance
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §56.1 Set appearance of all instances of the class
        // すべてのクラスやインスタンスの見た目を変更できる
        UIButton.appearance().tintColor = .green
        UILabel.appearance().textColor = .red
        UILabel.appearance().backgroundColor = .black
        UINavigationBar.appearance().tintColor = .cyan
        UINavigationBar.appearance().backgroundColor = .gray
        
        // §56.2 Appearance for class when contained in container class
        // コンテナに含まれているインスタンスに適用させる。
        UILabel.appearance(whenContainedInInstancesOf: [ViewController.self]).font = UIFont(name: "Helvetica Neue", size: 30)
        
    }


}

