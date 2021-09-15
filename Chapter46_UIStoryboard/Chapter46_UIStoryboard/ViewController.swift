//
//  ViewController.swift
//  Chapter46_UIStoryboard
//
//  Created by 小鍋涼太 on 2021/09/14.
//

import UIKit

// Chapter46 UIStoryboard

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §46.1 Getting an instance of UIStoryboard programmatically
        // bundlをnilにしたら、main Bundleを指定したのと同じ。
        let storyaboard = UIStoryboard(name: "Main", bundle: nil)
        _ = storyaboard.instantiateViewController(identifier: "yourController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // §46.2 Open another storyboard
        let storyboard = UIStoryboard(name: "StoryboardName", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewControllerID") as YourViewController
        self.present(vc, animated: true, completion: nil)
    }

}

class YourViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("you!")
    }
}
