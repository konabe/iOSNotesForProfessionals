//
//  ViewController.swift
//  Chapter87_CAGradientLayer
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §87.1 Creating a CAGradientLayer
        let subView = UIView(frame: CGRect(x: 20, y: 100, width: 150, height: 150))
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = subView.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        subView.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(subView)
        
        // §87.2 Animating a color change in CAGradientLayer
        let oldcolors = gradientLayer.colors
        let newColors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        gradientLayer.colors = newColors
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = oldcolors
        animation.toValue = newColors
        animation.duration = 0.3
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.delegate = self
        gradientLayer.add(animation, forKey: "animateGradientColorChange")
        
        // §87.3 Creating a horizontal CAGradientLayer
        let subView2 = UIView(frame: CGRect(x: 20, y: 300, width: 150, height: 150))
        let gradientLayer2 = CAGradientLayer()
        gradientLayer2.frame = subView2.bounds
        gradientLayer2.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
        gradientLayer2.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer2.endPoint = CGPoint(x: 1.0, y: 0.5) // ここを変える。
        subView2.layer.insertSublayer(gradientLayer2, at: 0)
        view.addSubview(subView2)
        
        // §87.4 Creating a horizontal CAGradientLayer with multiple colors
        let subView3 = UIView(frame: CGRect(x: 20, y: 500, width: 150, height: 150))
        let gradientLayer3 = CAGradientLayer()
        gradientLayer3.frame = subView2.bounds
        gradientLayer3.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.black.cgColor]
        gradientLayer3.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer3.endPoint = CGPoint(x: 1.0, y: 0.5)
        // §87.5 Creating a CGGradientLayer with multiple colors
        gradientLayer3.locations = [0.0, 0.2, 1.0]
        subView3.layer.insertSublayer(gradientLayer3, at: 0)
        view.addSubview(subView3)
    }


}

extension ViewController: CAAnimationDelegate {
    
}
