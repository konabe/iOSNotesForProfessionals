//
//  ViewController.swift
//  Chapter55_UIFeedbackGenerator
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

// iPhone7から、Taptic Engine®が搭載されている。
// Hapticsは触覚フィードバックを与える
// UIFeedbackGeneratorはそのままでは使えないので継承する。

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §55.1 Trigger Impact Haptic
        impactFeedbackGenerator.prepare()
        button.addAction(.init { _ in
            self.impactFeedbackGenerator.impactOccurred()
        }, for: .touchUpInside)
    }


}

