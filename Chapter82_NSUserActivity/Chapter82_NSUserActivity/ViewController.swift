//
//  ViewController.swift
//  Chapter82_NSUserActivity
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

// 主にSiriとアプリの連携。

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §82.1 Creating a NSUserActivity
        // Info.plistに加える
        let currentActivity = NSUserActivity(activityType: "com.gmail.konabe.rt.useractivity")
        currentActivity.title = "Current Activity"
        currentActivity.userInfo = ["informationKey": "value"]
        currentActivity.isEligibleForHandoff = true
        currentActivity.isEligibleForSearch = true
        currentActivity.isEligibleForPublicIndexing = false
        // Siriからの提案に表示される
        currentActivity.isEligibleForPrediction = true
        currentActivity.becomeCurrent()
        
        userActivity = currentActivity
    }


}

