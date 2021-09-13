//
//  ViewController.swift
//  Chapter43_UIControlEventHandlingWithBlocks
//
//  Created by 小鍋涼太 on 2021/09/13.
//

import UIKit

// Chapter43 UIControl - Event Handling with Blocks

@objc protocol ButtonEvent {
    @objc optional func onButtonPress(_ button: UIButton)
}

class ViewController: UIViewController, ButtonEvent {

    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // §43.1 Introduction
        // だいたいはselectorをコールバックとして追加する
        button.addTarget(self, action: #selector(ButtonEvent.onButtonPress(_:)), for: .touchUpInside)
    }
    
    // 実装しないと、ランタイムエラーになる。
    @objc func onButtonPress(_ button: UIButton) {
        print("PRESSED")
    }


}

