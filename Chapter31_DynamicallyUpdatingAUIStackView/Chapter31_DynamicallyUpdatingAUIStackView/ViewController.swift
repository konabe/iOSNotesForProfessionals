//
//  ViewController.swift
//  Chapter31_DynamicallyUpdatingAUIStackView
//
//  Created by 小鍋涼太 on 2021/09/05.
//

import UIKit

// Chapter 31 Dynamically updating a UIStackView

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var axisSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §31.1 Connect the UISwitch to an action we can animate switching between a horizontal or vertical layout of the image views
        
    }
    
    @IBAction func axisChange(sender: UISwitch) {
        UIView.animate(withDuration: 1.0) {
            self.updateConstraintsForAxis()
        }
    }
    
    func updateConstraintsForAxis() {
        if (axisSwitch.isOn) {
            stackView.axis = .vertical
        } else {
            stackView.axis = .horizontal
        }
    }
    
}

