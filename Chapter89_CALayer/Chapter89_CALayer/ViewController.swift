//
//  ViewController.swift
//  Chapter89_CALayer
//
//  Created by 小鍋涼太 on 2021/10/10.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    var myLayer = CATextLayer()
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // §89.1 Adding Transforms to a CALayer (translate, rocate, scale)
        // 移動、拡大、回転がある
        // layerのtransformプロパティにCATransform3Dを入れる。
        myLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        myLayer.backgroundColor = UIColor.systemTeal.cgColor
        myLayer.string = "Hello"
        myView.layer.addSublayer(myLayer)
        
        // iOSの原点は左上。
//        myLayer.transform = CATransform3DMakeTranslation(90, 50, 0)
        // 伸縮は中心を基準に行われる。
//        myLayer.transform = CATransform3DMakeScale(0.5, 3.0, 1.0)
        // x, y, zは回転の方向を決めてる。0にすると無効。
//        myLayer.transform = CATransform3DMakeRotation(30.0 * .pi / 180, 0, 0, 1)
        var transform = CATransform3DMakeTranslation(90, 50, 0)
        transform = CATransform3DRotate(transform, CGFloat(30.0 * .pi / 180), 0, 0, 1)
        transform = CATransform3DScale(transform, 0.5, 3.0, 1.0)
        myLayer.transform = transform
        
        // anchorPointはLayerの座標系0.0->1.0で指定, positionはsuperLayerの座標系で表現される
        // ２つ同時に変えないと、変なことになるらしい。
        
        // §89.3 Emitter View with custom image
        let subView2 = ConfettiView(frame: CGRect(x: 20, y: 300, width: 100, height: 100))
        view.addSubview(subView2)
        subView2.intensity = 1
        subView2.startConfetti()
        
        // §89.4 Rounded corners
        myLayer.masksToBounds = true
        myLayer.cornerRadius = 10
        
        // §89.6 How to add a UIImage to a CALayer
        let subView3 = UIView(frame: CGRect(x: 20, y: 450, width: 100, height: 100))
        subView3.backgroundColor = .yellow
        view.addSubview(subView3)
        let myImage = UIImage(named: "ninjin")?.cgImage
        let myLayer3 = CALayer()
        myLayer3.frame = subView3.bounds
        myLayer3.contents = myImage
        subView3.layer.addSublayer(myLayer3)
        
        myLayer3.contentsGravity = .resizeAspect // 画像がどの位置にくるかを決める
        myLayer3.isGeometryFlipped = true
        
        // §89.7 Disable Animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        // ここにかけばアニメーションしなくなる。
        CATransaction.commit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // §89.2 Shadows
        // TODO: うまくいかないので調査したい。
        let subView = CustomView(frame: CGRect(x: 20, y: 200, width: 200, height: 50))
        view.addSubview(subView)
    }


}

class CustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowOffset = CGSize(width: 20, height: 20)
        self.layer.backgroundColor = UIColor.red.cgColor
    }
}

class ConfettiView: UIView {
    var emitter: CAEmitterLayer!
    var colors: [UIColor]!
    var intensity: Float!
    private var active: Bool!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        colors = [.red, .green, .blue]
        intensity = 0.2
        active = false
    }
    
    func startConfetti() {
        // §89.5 Creating particles with CAEmitterLayer
        emitter = CAEmitterLayer()
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: -20)
        emitter.emitterShape = .line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }
    
    func stopConfetti() {
        emitter?.birthRate = 0
        active = false
    }
    
    func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.birthRate = 10.0 * intensity
        confetti.lifetime = 180.0 * intensity
        confetti.lifetimeRange = 0
        confetti.color = color.cgColor
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.velocityRange = CGFloat(40.0 * intensity)
        confetti.emissionLongitude = .pi
        confetti.emissionRange = .pi / 4
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.contents = UIImage(named: "thunder")?.cgImage
        return confetti
    }
    
    func isActive() -> Bool {
        return self.active
    }
    
}
