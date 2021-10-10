//
//  ViewController.swift
//  Chapter92_CustomFonts
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §92.1 Embedding custom fonts
        // Info.plistにFonts provided by applicationを入れて、そこにフォントファイル名を入れる
        UIFont.familyNames.forEach {
            print($0)
        }
        
        // §92.2 Applying custom fonts to control within a Storyboard
        
    }


}

