//
//  ViewController.swift
//  Chapter61_ChangeStatusBarColor
//
//  Created by 小鍋涼太 on 2021/09/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let messageBarViewController = MessageBarViewController()
    func childViewControllerForStatusBarStyle() -> UIViewController? {
        messageBarViewController
    }

    // §61.1
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent // .darkContentはステータスバーの色が黒 , .lightContentは白になる。
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §61.1 For non-UINavigationBar status bars
        // info.plistに"View controller-based status bar appearance"を設定してYESにする。
        
        // §61.2 For UINavigationBar status bars
        title = "test"
        navigationController?.navigationBar.barStyle = .black
        
        // §61.3 For ViewController containment
        setNeedsStatusBarAppearanceUpdate()
        
        // §61.4 If you cannot ViewController's code
        let viewController = UIViewController()
        viewController.navigationController?.navigationBar.barStyle = .black
        
        // §61.5 Changing the status bar style for the entire application
        // info.plistに"View controller-based status bar appearance"を設定してNOにする。
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
}

class MessageBarViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
}

