//
//  ViewController.swift
//  Chapter11_UIImageView
//
//  Created by 小鍋涼太 on 2021/08/27.
//

import UIKit

// Chapter 11: UIImageView

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var maskLabel: UILabel!
    @IBOutlet weak var schlossImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §11.1 UIImage masked with Label
        // NOTE: Objective-Cの方法(layerを挟む)をそのままやろうとすると失敗する。
        imageView.mask = maskLabel
        imageView.layer.masksToBounds = true
        
        // §11.3 How the Mode property affects an image.
        // contentMode
        schlossImageView.contentMode = .bottomLeft
        // .scaleToFill: 画像の縦横がUIImageViewのサイズに合うように伸びる。
        // .aspectFit: 縦横のうち長い方はサイズに合うように伸びる。（もう片方は歪まないように伸びる）
        // .aspectFill: 短い方がサイズに合うように伸びる。（アスペクト比が変わらないように）
        // .redraw: カスタムビューのときによく使う。UIImageViewだと.scaleToFillと変わらない。geometryが変わったら自動的にdrawRectが呼ばれる。できるだけ使わない方がいい。
        // .center, .top, .bottom, .left, .right, .topLeft, .topRight, .bottomLeft, .bottomRight: 伸縮は行われず、そこだけくり抜かれる。
        
        // §11.4 Animating a UIImageView
        // Chapter8 でやっているので省略。
        // 簡単だが、処理が遅くなり、リソースを消費するのでLayerやSpriteKitを使ったほうがいい。
        
        // §11.5 Create a UIImageView
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 20, y: 300, width: 200, height: 100)
        imageView.image = UIImage(named: "sea")
        view.addSubview(imageView)
        
        // §11.6 Change color of an image
        let monsterView = UIImageView(frame: CGRect(x: 20, y: 500, width: 300, height: 300))
        // tintColorは元画像のアルファ値をもとに計算しているらしい。
        monsterView.tintColor = .black
        monsterView.image = UIImage(named: "monster")?.withRenderingMode(.alwaysTemplate)
        view.addSubview(monsterView)
        
        // §11.7 Assigning an image to a UIImageView
        _ = UIImageView(image: UIImage(named: "sea"), highlightedImage: UIImage(named: "monster"))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // §11.2 Making an image into a circle or rounded
        // Auto Layoutを使っているならviewDidLayoutSubviewsに書くべき。
        // 画像のサイズが変わるときに更新される。
        schlossImageView.layer.cornerRadius = schlossImageView.frame.height / 2
        // 透明化を加えて起こるパフォーマンスの低下を低減できる
        schlossImageView.layer.shouldRasterize = true
        schlossImageView.clipsToBounds = true
    }


}

