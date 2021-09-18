//
//  ViewController.swift
//  Chapter49_UIFont
//
//  Created by 小鍋涼太 on 2021/09/16.
//

import UIKit

// Chapter49 UIFont
// フォント関係の情報を取得したり設定したりする。
// NSObject, Hashable, Equatable, NSCopyingを継承してる

class ViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // §49.1 Declaring and initializing UIFont
        // UIFontはフォントの名前が間違っているとnilになる。
        let helveticaNeue = UIFont(name: "Helvetica Neue", size: 15)
        
        // §49.2 Chaining the font of a label
        firstLabel.font = helveticaNeue
        
    }


}

