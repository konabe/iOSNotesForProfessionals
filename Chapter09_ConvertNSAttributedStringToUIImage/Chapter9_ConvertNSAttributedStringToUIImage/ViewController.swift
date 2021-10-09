//
//  ViewController.swift
//  Chapter9_ConvertNSAttributedStringToUIImage
//
//  Created by 小鍋涼太 on 2021/08/27.
//

import UIKit

// Chapter 9: Convert NSAttributedString to UIImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // § 9.1 NSAttributedString to UIImage Conversion
        let str = NSMutableAttributedString(string: "Hello. That is a test attributed string.")
        str.addAttribute(.backgroundColor, value: UIColor.yellow, range: NSRange(location: 3, length: 5))
        str.addAttribute(.foregroundColor, value: UIColor.green, range: NSRange(location: 10, length: 7))
        str.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: 20)!, range: NSRange(location: 20, length: 10))
        let customImage = imageFromAttributedString(text: str)
        
        imageView.image = customImage
        
    }
    
    private func imageFromAttributedString(text: NSAttributedString) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(text.size(), false, 0.0)
        // ここがポイント
        text.draw(at: CGPoint(x: 0, y: 0))
        let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
        UIGraphicsEndImageContext()
        return image
    }
}

