//
//  ViewController.swift
//  Chapter42_UIActivityViewController
//
//  Created by 小鍋涼太 on 2021/09/12.
//

import UIKit

// Chapter42 UIActivityViewController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // §42.1 Initializing the Activity View Controller
        let textToShare = "Stack Over Flowの内容をシェアします。"
        let documentationURL = URL(string: "https://stackoverflow.com/tour/documentation")!
        let activityVC = UIActivityViewController(activityItems: [textToShare, documentationURL], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
}

