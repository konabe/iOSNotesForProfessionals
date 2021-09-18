//
//  ViewController.swift
//  Chapter53_UIBezierPath
//
//  Created by 小鍋涼太 on 2021/09/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §53.1 Designing and drawing a Bezier Path
        let myView = MyCustomview(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        myView.backgroundColor = .yellow
        view.addSubview(myView)
        
        // §53.2 Howt to apply corner radius to rectangles drawn by UIBezierPath
        let cornerView = UIView(frame: CGRect(x: 100, y: 200, width: 80, height: 80))
        cornerView.backgroundColor = .gray
        let path = UIBezierPath(
            roundedRect: cornerView.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 11, height: 11))
        cornerView.layer.mask = {
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            return layer
        }()
        view.addSubview(cornerView)
        
        // §53.3 How to apply shadows to UIBezierPath
        // TODO: うまくいかなかった。
//        let context = UIGraphicsGetCurrentContext()
//        let shadow = NSShadow()
//        shadow.shadowColor = UIColor.black
//        shadow.shadowOffset = CGSize(width: 7, height: 5)
//        shadow.shadowBlurRadius = 5
//        context!.saveGState()
//        context!.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
//        UIColor.gray.setFill()
//        path.fill()
//        context!.restoreGState()
        
        // §53.4 How to create a simple shapes using UIBezierPath
        let ovalView = UIView(frame: CGRect(x: 100, y: 300, width: 80, height: 80))
        ovalView.backgroundColor = .gray
        let layer = CAShapeLayer()
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 50, height: 50))
        layer.path = ovalPath.cgPath
        ovalView.layer.mask = layer
        view.addSubview(ovalView)
        
        // §53.5 UIBezierPath + AutoLayout
        // オートレイアウトで大きさが変わるときは、drawRectの中に書いて、引数のframeから大きさを受け取るべき
        
        // §53.6 pie view & column view with UIBezierPath
        // 今までの応用なので省略

    }


}

@IBDesignable class MyCustomview: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // drawRectに書く方法もあるが、遅くなるので必要なければやめたほうがいい。
    
    func setup() {
        let shapeLayer = CAShapeLayer()
        let path = createBezierPath()
        let scale = CGAffineTransform(scaleX: 2, y: 2)
        path.apply(scale)
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 10, y: 10)
        self.layer.addSublayer(shapeLayer)
    }
    
    private func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath()
        
        // スタート地点にいく（左下）
        path.move(to: CGPoint(x: 2, y: 26))
        // segment1: 下から上に直線を書く
        path.addLine(to: CGPoint(x: 2, y: 15))
        // segment2: 曲線を描く
        path.addCurve(
            to: CGPoint(x: 0, y: 12),
            controlPoint1: CGPoint(x: 2, y: 14),
            controlPoint2: CGPoint(x: 0, y: 14)
        )
        // segment3: 下から上の直線
        path.addLine(to: CGPoint(x: 0, y: 2))
        // segment4: 左上の円
        path.addArc(
            withCenter: CGPoint(x: 2, y: 2),
            radius: 2,
            startAngle: CGFloat(2.0 * Double.pi / 2),
            endAngle: CGFloat(3.0 * Double.pi / 2),
            clockwise: true
        )
        // segment5: 上の直線
        path.addLine(to: CGPoint(x: 8, y: 0))
        // segment6: 右上の円
        path.addArc(
            withCenter: CGPoint(x: 8, y: 2),
            radius: 2,
            startAngle: CGFloat(3.0 * Double.pi / 2),
            endAngle: CGFloat(4.0 * Double.pi / 2),
            clockwise: true
        )
        // segment7: 右の直線
        path.addLine(to: CGPoint(x: 10, y: 12))
        // segment8: 曲線
        path.addCurve(
            to: CGPoint(x: 8, y: 15),
            controlPoint1: CGPoint(x: 10, y: 14),
            controlPoint2: CGPoint(x: 8, y: 14)
        )
        // segment9: 直線
        path.addLine(to: CGPoint(x: 8, y: 26))
        
        path.close()
        return path
    }
    
}
