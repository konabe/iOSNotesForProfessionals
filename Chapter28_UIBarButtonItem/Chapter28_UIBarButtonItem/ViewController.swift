//
//  ViewController.swift
//  Chapter28_UIBarButtonItem
//
//  Created by 小鍋涼太 on 2021/09/05.
//

import UIKit

// Chapter 28 UIBarButtonItem

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §28.1 Creating a UIBarButtonItem in the Interface Builder
        // IBでNavigationControllerをEmbedする。
        // (UINavigationBarを追加するのもあり)
        // IBでBarButtomItemを追加する
        // SystemItemをRefreshに変更
        
        // §28.2 Creating a UIBarButtonItem
        let barButtomItem = UIBarButtonItem(title: "Greetings!", style: .plain, target: self, action: #selector(barButtonTapped(_:)))
        navigationItem.rightBarButtonItems?.append(barButtomItem)
        
        // §28.3 Bar Button Item Original Image with no Tint color
        barButtomItem.image = barButtomItem.image?.withRenderingMode(.alwaysOriginal)
    }
    
    @IBAction func refreshBarButtonItemTap(_ sender: UIBarButtonItem) {
        print("How refreshing!")
    }
    
    @objc
    private func barButtonTapped(_ sender: UIBarButtonItem) {
        print("tapped")
    }
    
}

