//
//  ViewController.swift
//  Chapter62_UISegmentedControl
//
//  Created by 小鍋涼太 on 2021/09/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §62.1 Creating UISegmentedControl via code
        let mySegmentControl = UISegmentedControl(items: ["One", "Two", "Three"])
        mySegmentControl.frame = CGRect(x: 0, y: 50, width: 300, height: 50)
        mySegmentControl.selectedSegmentIndex = 0
        mySegmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        view.addSubview(mySegmentControl)
    }

    @objc func segmentedValueChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
    }

}

