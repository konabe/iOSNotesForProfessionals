//
//  ViewController.swift
//  Chapter74_NSNotificationCenter
//
//  Created by 小鍋涼太 on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §74.1 Removing Observers
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "TestNotification"), object: nil)
        NotificationCenter.default.removeObserver(self)
        
        // §74.2 Adding an Observer
        // §74.7 Adding/Removing an Observer with a Block
        NotificationCenter.default.addObserver(forName: Notification.Name(rawValue: "TestNotification"), object: nil, queue: nil) { notification in
            // §74.6 Observing a Notification
            let userInfo: [AnyHashable: Any] = notification.userInfo!
            print("TestNotification fired \(userInfo["someKey"].debugDescription)")
        }
        
        // §74.3 Posting a Notification with Data
        // §74.5 Posting a Notification
        let userInfo: [String: Any] = ["someKey": "hoge"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TestNotification"), object: self, userInfo: userInfo)
        
        // §74.4 Add and remove obserber for name
        // 今は使えなさそう
        
        
    }


}

