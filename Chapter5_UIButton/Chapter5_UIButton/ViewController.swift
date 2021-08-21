//
//  ViewController.swift
//  Chapter5_UIButton
//
//  Created by 小鍋涼太 on 2021/08/22.
//

import UIKit

// Chapter5: UIButton
// UIControlはタッチイベントを傍受したり、アクションメッセージを送ることができる

class ViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // §5.1 Creating a UIButton, UIButtonの作成
        _ = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        _ = UIButton(type: .custom)
        _ = UIButton(type: .infoDark)
        
        // §5.2 Attaching a Method to a Button, メソッドの紐付け
        actionButton.addTarget(self, action: #selector(someButtonActionObjc), for: .touchUpInside)
        actionButton.addAction(.init { _ in self.someButtonAction() }, for: .touchUpInside)
        
        // §5.3 Setting Font, フォントの設定
        actionButton.titleLabel?.font = UIFont(name: "HiraMinProN-W3", size: 30)
    }
    
    @objc func someButtonActionObjc() {
        print("addTarget: Button is tapped \(Date())")
    }
    
    func someButtonAction() {
        print("addAction: Button is tapped \(Date())")
    }

}

