//
//  ViewController.swift
//  Chapter51_MakeSelectiveUIViewCornersRounded
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §51.1 Objective C code to make selected corner of a UIView rounded
        let view1 = UIView()
        view1.backgroundColor = UIColor(red: 255/255.0, green: 193/255.0, blue: 72/255.0, alpha: 1.0)
        view1.frame = CGRect(x: 0, y: 0.1422*view.frame.height - 10, width: view.frame.width*0.97, height: view.frame.height*0.2158)
        setMaskTo(view1, byRoundingcorners: UIRectCorner([.bottomRight, .topRight]))
        view.addSubview(view1)
    }
    
    private func setMaskTo(_ view: UIView, byRoundingcorners corners: UIRectCorner) {
        let rounded = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 20.0, height: 20.0))
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        view.layer.mask = shape
    }

}

