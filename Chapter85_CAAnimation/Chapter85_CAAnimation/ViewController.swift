//
//  ViewController.swift
//  Chapter85_CAAnimation
//
//  Created by 小鍋涼太 on 2021/10/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func oneAnimationTapped(_ sender: Any) {
        // §85.1 Animate a view from one position to another
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.fromValue = 20.0
        animation.toValue = 500.0
        label.layer.add(animation, forKey: "basic")
    }
    
    @IBAction func tossTapped(_ sender: Any) {
        // §85.2 Animate View - Toss
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = .push
        transition.subtype = .fromLeft
        transition.duration = 0.8
        transition.repeatCount = 5
        label.layer.add(transition, forKey: "transition")
    }
    
    @IBAction func pushViewAnimationTapped(_ sender: Any) {
        // §83.3 Push View Animation
        let animation = CATransition()
        animation.subtype = .fromRight
        animation.duration = 0.5
        animation.type = .push
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        label.layer.add(animation, forKey: "SwitchToView1")
    }
    
    @IBAction func revolveViewTapped(_ sender: Any) {
        // §85.4 Resolve View
        let boundingRect = CGRect(x: -50, y: -50, width: 100, height: 100)
        let orbit = CAKeyframeAnimation()
        orbit.keyPath = "position"
        orbit.path = CGPath(ellipseIn: boundingRect, transform: nil)
        orbit.duration = 1
        orbit.isAdditive = true
        orbit.repeatCount = 2
        orbit.calculationMode = .paced
        orbit.rotationMode = .rotateAuto
        label.layer.add(orbit, forKey: "orbit")
    }
    
    @IBAction func shakeViewTapped(_ sender: Any) {
        // §85.5 Shake View
        let animation = CAKeyframeAnimation(keyPath: "position.x")
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, NSNumber(value: 1/6), NSNumber(value: 3/6), NSNumber(value: 5/6), 1]
        animation.duration = 0.4
        animation.isAdditive = true
        label.layer.add(animation, forKey: "shake")
    }
    
    
}

