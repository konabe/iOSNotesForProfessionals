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
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var disabledButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §5.1 Creating a UIButton, UIButtonの作成
        _ = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 20))
        _ = UIButton(type: .custom)
        _ = UIButton(type: .infoDark)
        
        // §5.2 Attaching a Method to a Button, メソッドの紐付け
        // §5.11 Adding an action to an UIButton via Code ( programatically )
        actionButton.addTarget(self, action: #selector(someButtonActionObjc), for: .touchUpInside)
        actionButton.addAction(.init { _ in self.someButtonAction() }, for: .touchUpInside)
        
        // §5.3 Setting Font, フォントの設定
        actionButton.titleLabel?.font = UIFont(name: "HiraMinProN-W3", size: 30)
        
        // §5.4 Set Image, 画像の設定
        //imageButton.setImage(nil, for: .normal) // 何も起こらない
        imageButton.setImage(UIImage(named: "player_button"), for: .normal)
        // imageButton.setImage(UIImage(named: "player_button"), for: [.selected, .highlighted]) // こうすることもできるが、実際どうなるのかわからない
        imageButton.contentMode = .scaleToFill
        
        // §5.5 Get UIButton's size strictly based on its text and font, テキストやフォントに基づいた厳密なサイズを取得する
        print(imageButton.intrinsicContentSize)
        
        // §5.6 Disabling a UIButton
        disabledButton.adjustsImageWhenDisabled = false // これをやるとDisabledのときに画像が変わらなくなるらしいが、確認できなかった。
        disabledButton.isEnabled = true
        disabledButton.setImage(UIImage(systemName: "star"), for: .normal)
        disabledButton.setImage(UIImage(systemName: "star.fill"), for: .disabled)
        
        // §5.7 Set title
        disabledButton.setTitle("Hello, disabled!", for: .normal)
        
        // §5.8 Set title color
        disabledButton.setTitleColor(.purple, for: .normal)
        
        // §5.9 Horizontally aligning contents
        disabledButton.contentHorizontalAlignment = .right
        
        // §5.10 Getting the title label
        let label = disabledButton.titleLabel
        print(label!.text!)
        label?.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    @objc func someButtonActionObjc() {
        print("addTarget: Button is tapped \(Date())")
    }
    
    func someButtonAction() {
        print("addAction: Button is tapped \(Date())")
        disabledButton.isEnabled = false
    }

}

