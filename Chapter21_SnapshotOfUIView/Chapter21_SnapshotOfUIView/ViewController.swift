//
//  ViewController.swift
//  Chapter21_SnapshotOfUIView
//
//  Created by 小鍋涼太 on 2021/09/02.
//

import UIKit
import AVFoundation

// Chapter 21: Snapshot of UIView

class ViewController: UIViewController {
    
    @IBOutlet weak var screenshotView: UIImageView! {
        willSet {
            newValue.layer.borderWidth = 5
            newValue.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §21.2 Snapshot with subview with other markup and text
        // TODO: あとでやる。
    }

    @IBAction func takeScreenshot(_ sender: Any) {
        // §21.1 Getting the Snapshot
        UIGraphicsBeginImageContext(self.view.bounds.size)
        let context = UIGraphicsGetCurrentContext()!
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        screenshotView.image = screenshot
    }
    
}

