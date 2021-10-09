//
//  ViewController.swift
//  Chapter7_UILocalNotification
//
//  Created by 小鍋涼太 on 2021/08/24.
//

import UIKit

// Chapter7: UILocalNotification
// Local Notificationはサーバーを使わずにユーザーに通知できる。
// Local Notificationはスケジュールして、アプリ内でトリガーする
// iOS10でdeprecatedになっているので、UserNotifications frameworkを使うこと。

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §7.1 Scheduling a local notification
        // 5秒後にプッシュ通知がくる
        let notification = UILocalNotification()
        notification.alertBody = "Hello, local notifications!"
        notification.fireDate = Date().addingTimeInterval(10)
        UIApplication.shared.scheduleLocalNotification(notification)
    }


}

