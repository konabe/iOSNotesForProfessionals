//
//  ViewController.swift
//  Chapter8_UIImage
//
//  Created by 小鍋涼太 on 2021/08/25.
//

import UIKit
import WebKit

// Chapter8: UIImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var screenshotView: UIImageView!
    @IBOutlet weak var tintImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §8.1 Creating UIImage
        // named:は画像データをメモリにキャッシュする。メモリの問題になることがある。
        let ofuroImage = UIImage(named: "ofuro_onsen_young_man")
        // こっちでやればキャッシュせずにすむ。
        // § 8.8 Creating and Initializing Image Objects with file contents
        _ = UIImage(contentsOfFile: Bundle.main.path(forResource: "ofuro_onsen_young_man", ofType: "png")!)
        
        // Base64の画像データも表示できる。
        let imageData = Data(base64Encoded: base64Str, options: .ignoreUnknownCharacters)
        _ = UIImage(data: imageData!)
        
        // UIColorから画像を生成することもできる。
        let color: UIColor = .red
        let size = CGSize(width: 200, height: 200)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(origin: .zero, size: size))
        _ = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        
        // ファイルから
        _ = UIImage(contentsOfFile: Bundle.main.path(forResource: "ofuro_onsen_young_man", ofType: "png")!)
        // imageView.image = image
        
        // 配列を生成してアニメーションを実行する
        var imageArray = [UIImage]()
        for postfix in ["yellow", "red", "blue"] {
            imageArray.append(UIImage(contentsOfFile: Bundle.main.path(forResource: "shingouki_\(postfix)", ofType: "png")!)!)
        }
        imageView.animationImages = imageArray
        imageView.animationDuration = 3
        imageView.startAnimating()
        
        // §8.2 Comparing Images
        let image1 = UIImage(named: "ofuro_onsen_young_man")
        let image2 = UIImage(named: "ofuro_onsen_young_man")
        if let image1 = image1 {
            // iOS10あたりでは==だとfalseになったらしいが、iOS14では問題なし。
            // キャッシュを使ってるのだから同じ画像として判定されてほしいので直感的な挙動にはなったはず。
            print("image1==image2 > \(image1==image2), image1.isEqual(image2) > \(image1.isEqual(image2))")
        }
        
        // §8.3 Gradient Image with Colors
        // § 8.10 Gradient Background Layer for Bounds
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientImageView.bounds
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.blue.cgColor]
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        gradientImageView.image = gradientImage
        
        // §8.4 Convert UIImage to/from base64 encoding
        // エンコード
        let ofuroPngData = ofuroImage?.pngData()
        let ofuroBase64 = ofuroPngData?.base64EncodedString(options: .lineLength64Characters)
        if let base64 = ofuroBase64 {
            let startInd = base64.index(base64.startIndex, offsetBy: 0)
            let endInd = base64.index(base64.startIndex, offsetBy: 100)
            print("Base64[0...100] = \(String(base64[startInd...endInd])))")
        }
        // デコード
        // NOTE: ofuroPngDataをそのままデコードできない。データ量が大きすぎるからか？
        let data = Data(base64Encoded: base64Str)
        let decodedImage = UIImage(data: data!)
        gradientImageView.image = decodedImage
        
        // §8.5 Take a Snapshot of a UIView
        webview.load(URLRequest(url: URL(string: "https://www.google.com/")!))

        // §8.6 Change UIImage Color
        let maskImage = ofuroImage!.cgImage
        let width = ofuroImage!.size.width
        let height = ofuroImage!.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        bitmapContext!.clip(to: bounds, mask: maskImage!)
        bitmapContext!.setFillColor(UIColor.blue.cgColor)
        bitmapContext!.setAlpha(0.2)
        bitmapContext!.fill(bounds)
        
        if let cImage = bitmapContext!.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            gradientImageView.image = coloredImage
        }
        
        // § 8.7 Apply UIColor to UIImage
        let ofuroImage2 = UIImage(named: "ofuro_onsen_young_man")?.withRenderingMode(.alwaysTemplate)
        tintImageView.image = ofuroImage2
        tintImageView.tintColor = .purple.withAlphaComponent(0.2)
        
        // § 8.9 Resizable image with caps
        // 何が起こっているか調査したほうがいい
        ofuroImage2?.resizableImage(withCapInsets: UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0), resizingMode: .stretch)
        tintImageView.image = ofuroImage2
        
    }
    
    @IBAction func screenshotButtonTapped() {
        UIGraphicsBeginImageContextWithOptions(webview.bounds.size, false, UIScreen.main.scale)
        webview.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let jpgPath = NSHomeDirectory() + "/Documents/screenshot.jpg"
        
        let screenData = screenImage?.jpegData(compressionQuality: 1.0)
        try! screenData?.write(to: URL(fileURLWithPath: jpgPath), options: .atomicWrite)
        screenshotView.image = UIImage(data: screenData!)
    }
    

    private let base64Str =
        "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"

}
