//
//  ViewController.swift
//  Chapter13_CutAUIImageIntoACircle
//
//  Created by 小鍋涼太 on 2021/08/28.
//

import UIKit

// Chapter 13: Cut a UIImage into a circle

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §13.1 Cut a image into a circle - Objective C
        // §13.2 Swift Example
        let imageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 320, height: 320))
        view.addSubview(imageView)
        let image = UIImage(named: "bee")
        imageView.image = circularScaleAndCropImage(image!, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let originalImageView = UIImageView(frame: CGRect(x: 0, y: 400, width: 200, height: 200))
        view.addSubview(originalImageView)
        originalImageView.image = UIImage(named: "bee")
        originalImageView.contentMode = .scaleAspectFit
    }

    private func circularScaleAndCropImage(_ image: UIImage, frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        let scaleFactorX = frame.width / image.size.width
        let scaleFactorY = frame.height / image.size.height
        let imageCenterX = frame.width / 2
        let imageCenterY = frame.height / 2
        let radius = frame.width / 2
        context?.beginPath()
        // 円を描いてくり抜く
        context?.addArc(center: CGPoint(x: imageCenterX, y: imageCenterY), radius: radius, startAngle: 0, endAngle: 2 * CGFloat(Float.pi), clockwise: false)
        context?.clip()
        context?.scaleBy(x: scaleFactorX, y: scaleFactorY)
        let myRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        image.draw(in: myRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

}

