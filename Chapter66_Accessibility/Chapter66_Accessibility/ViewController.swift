//
//  ViewController.swift
//  Chapter66_Accessibility
//
//  Created by 小鍋涼太 on 2021/09/26.
//

// 聴覚障害者や視覚障害者がアクセスするため

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §66.1 Make a View Accessible
        // VoiceOver(Screen Reader)に反映される
        subView.isAccessibilityElement = true
        
        // §66.2 Accessibility Frame
        subView.accessibilityFrame = subView.frame.insetBy(dx: 10, dy: 10)
        
        // §66.3 Layout Change
        // 新しい要素が増えてレイアウトが変わったことを通知できる。
        titleLabel.isAccessibilityElement = true
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: titleLabel)
        
        // §66.4 Accessibility Container
        // 読み上げ順の制御などに使う
        subView.accessibilityElements = [
            titleLabel!
        ]
        
        // §66.5 Hiding Elements
        subView.isHidden = true
        // VoiceOverに要素が消えたことを通知できる
        subView.accessibilityElementsHidden = true
        
        // §66.6 Screen Change
        subView.isHidden = false
        subView.accessibilityElementsHidden = false
        UIAccessibility.post(notification: UIAccessibility.Notification.screenChanged, argument: titleLabel)
        
        // §66.7 Announcement
        UIAccessibility.post(notification: UIAccessibility.Notification.announcement, argument: "The thing happended!")
        
        // §66.8 Ordering Elements
        titleLabel.shouldGroupAccessibilityChildren = true
        
        // §66.9 Modal View
        titleLabel.accessibilityViewIsModal = true
    }


}

