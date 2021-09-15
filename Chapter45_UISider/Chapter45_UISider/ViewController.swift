//
//  ViewController.swift
//  Chapter45_UISider
//
//  Created by 小鍋涼太 on 2021/09/14.
//

import UIKit

// Chapter45: UISlider

class ViewController: UIViewController {
    private var subSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        // §45.1 UISlider
        // §45.2 Swift Example
        let slider = UISlider(frame: CGRect(x: 0, y: 100, width: 320, height: 10))
        slider.addTarget(self, action: #selector(sliderAction(_:)), for: .valueChanged)
        slider.backgroundColor = .clear
        slider.minimumValue = 0.0
        slider.maximumValue = 50.0
        // ここをfalseにすると、離したときに更新されるようになる
        slider.isContinuous = true
        slider.value = 25.0
        view.addSubview(slider)
        
        // §45.3 Adding a custom thumb image
        subSlider = UISlider(frame: CGRect(x: 0, y: 200, width: 320, height: 10))
        subSlider.setThumbImage(UIImage(systemName: "star"), for: .normal)
        subSlider.minimumValue = 0.0
        subSlider.maximumValue = 50.0
        slider.value = 25.0
        view.addSubview(subSlider)
    }
    
    @objc func sliderAction(_ sender: UISlider) {
        subSlider.value = 50 - sender.value
    }


}

