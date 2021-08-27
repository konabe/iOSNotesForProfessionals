//
//  ViewController.swift
//  Chapter12_ResizingUIImage
//
//  Created by 小鍋涼太 on 2021/08/28.
//

import UIKit

// Chapter 12: Resizing UIImage
// CGInterpolationQuality: Interpolation(内挿)のクオリティ
// ここでいうリサイズは画像のクオリティの話？

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "bee")!
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.interpolationQuality = .low
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = resizedImage
        
    }

}

