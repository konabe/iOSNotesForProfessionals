//
//  ViewController.swift
//  Chapter20_UIView
//
//  Created by 小鍋涼太 on 2021/08/31.
//

import UIKit

// Chapter 20: UIView

class ViewController: UIViewController {

    var subview1: UIView!
    var subview2: UIView!
    var animatingview: UIView!
    @IBOutlet weak var roundendView: UIView!
    @IBOutlet weak var myImageView: MyImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §20.1 Make the view rounded
        roundendView.clipsToBounds = true
        roundendView.layer.cornerRadius = 10
        // ストーリーボードでの設定も同様にしてある。
        // Clips to Bounds, layer
        
        // @discardableResultが使われていたので。
        // 帰り値を変数にいれようとしなくても警告にならないアノテーション
        testdiscardableResult()
        
        // §20.2 Using IBInspectable and IBDesignable
        // IBInspectableとIBDesignableはUIViewに使える
        
        // §20.3 Taking a snapshot
        // UIViewのコピーを取りたいときに使う？
        // 実行するとレイアウトが崩れる
        //_ = roundendView.snapshotView(afterScreenUpdates: true)
        
        // §20.4 Create a UIView
        let myFrame = CGRect(x: 200, y: 200, width: 20, height: 20)
        let myView = UIView(frame: myFrame)
        myView.backgroundColor = .brown
        view.addSubview(myView)
        
        // §20.5 Shake a View
        myView.shake()
        
        // §20.6
        myImageView.image = UIImage(named: "placehold")
        
        // §20.7 Programmatically manage UIView insertion and deletion into and from another UIView
        subview1 = UIView(frame: CGRect(x: 10, y: 0, width: 20, height: 20))
        subview1.backgroundColor = .cyan
        myImageView.addSubview(subview1)
        subview2 = UIView(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        subview2.backgroundColor = .magenta
//        myImageView.addSubview(subview2)
//        myImageView.insertSubview(subview2, belowSubview: subview1)
        // 重なり順が普通のaddSubViewとは変わる。
        myImageView.insertSubview(subview2, aboveSubview: subview1)
        // SubViewは下記のように配列で管理されている。
        print(myImageView.subviews.map(\.frame))
        
        // §20.8 Create UIView using Autolayout
        let autolayoutView = UIView()
        autolayoutView.backgroundColor = .black.withAlphaComponent(0.1)
        autolayoutView.isUserInteractionEnabled = false
        let autolayoutView2 = UIView()
        autolayoutView2.backgroundColor = .red.withAlphaComponent(0.1)
        autolayoutView2.isUserInteractionEnabled = false
        view.addSubview(autolayoutView)
        view.addSubview(autolayoutView2)
        addView(subView: autolayoutView, onParentView: view, withHeight: 500)
        addFullResizeConstraintForSubview(subview: autolayoutView2, addedOnParentView: view)
        
        // §20.9 Animating a UIView
        animatingview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        animatingview.backgroundColor = .orange
        view.addSubview(animatingview)
        
        // §20.10 UIView extension for size and frame attributes
        // view.frame.origin.x とか書くのが面倒なので
        // view.xとかけるようにしましょうという話。
        // setterはCGRectでframeに入れるように実装する。
        // xのsetterだったら、newValueをCGRectのxにいれて、それ以外はself.frameから取り出す感じ。
 
    }
    
    // §20.8
    private func addView(subView: UIView, onParentView parentView: UIView, withHeight height: CGFloat) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(
            item: subView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 10.0
        )
        let top = NSLayoutConstraint(
            item: subView,
            attribute: .top,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .top,
            multiplier: 1.0,
            constant: 10.0
        )
        let leading = NSLayoutConstraint(
            item: subView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 10.0
        )
        parentView.addConstraints([trailing, top, leading])
        let height = NSLayoutConstraint(
            item: subView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 0.0,
            constant: height
        )
        parentView.addConstraint(height)
    }
    
    // §20.8
    private func addFullResizeConstraintForSubview(subview: UIView, addedOnParentView parentView: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -10
        )
        let top = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .top,
            multiplier: 1.0,
            constant: 10
        )
        let leading = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .leading,
            multiplier: 1.0,
            constant: 10
        )
        let bottom = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: parentView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )
        parentView.addConstraints([trailing, top, leading, bottom])
    }
    
    // §20.7
    @IBAction func hikkurikaesu(_ sender: Any) {
        myImageView.bringSubviewToFront(subview1)
    }
    
    // §20.8
    @IBAction func kesu(_ sender: Any) {
        subview1.removeFromSuperview()
    }
    
    // §20.9
    @IBAction func doAnime(_ sender: Any) {
        UIView.animate(withDuration: 0.75, delay: 0.5, options: .curveEaseIn, animations: {
            self.animatingview.frame.origin.x = 100
            self.animatingview.frame.origin.y = 100
        }) { finished in
            self.animatingview.backgroundColor = .blue
        }
    }
    
    @discardableResult
    private func testdiscardableResult() -> String {
        return ""
    }


}

// §20.2

@IBDesignable
class CustomView: UIView {
    @IBInspectable var textColor: UIColor = .black
    @IBInspectable var text: String?
    @IBInspectable var showText: Bool = true
    
    override func draw(_ rect: CGRect) {
        if showText {
            if let text = text {
                let s = NSString(string: text)
                s.draw(in: rect, withAttributes: [
                    .foregroundColor: textColor,
                    .font: UIFont(name: "Helvetica Neue", size: 18)!
                ])
            }
        }
    }
}

class MyImageView: UIView {
    var image: UIImage! {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config() {
        backgroundColor = .orange.withAlphaComponent(0.2)
    }
    
    // §20.6 Utilizing Intrinsic Content Size
    // heightとwidthの制約をハードコードしなくてすむようになる
    // (Auto Layoutを見ると制約が満たされていないのにきちんと大きさが決まっている)
    // 制約エラーを消すには、IntrinsicSizeをPlaceholderにして適当な値を入れておく。
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: image.size.height)
    }
    
}

// §20.2 このようにエクステンションにかくこともできる。
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    // §20.5
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -7.0, 7.0, -5.0, 5.0, 0]
        layer.add(animation, forKey: "shake")
    }
}
