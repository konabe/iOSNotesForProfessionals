//
//  ViewController.swift
//  Chapter23_UIColor
//
//  Created by 小鍋涼太 on 2021/09/03.
//

import UIKit

// Chapter23 UIColor

class ViewController: UIViewController {

    @IBOutlet weak var lighterView: UIView!
    @IBOutlet weak var patternImageView: UIView!
    @IBOutlet weak var darkerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §23.1 Creating a UIColor
        _ = UIColor.red
        _ = UIColor.blue
        // 型が決まっていればUIColorを省略できる
        view.backgroundColor = .yellow
        // グレースケール
        _ = UIColor(white: 0.5, alpha: 1.0)
        // HSB
        _ = UIColor(hue: 0.4, saturation: 0.3, brightness: 0.7, alpha: 1.0)
        // RGBA
        _ = UIColor(red: 30.0/255, green: 70.0/255, blue: 200.0/255, alpha: 1.0)
        // §23.5: UIColor from an image pattern
        patternImageView.backgroundColor = UIColor(patternImage: UIImage(named: "sea")!)
        
        // §23.2 Creating a UIColor form hexaadecimal number or string
        view.backgroundColor = UIColor(hex: 0xff00ff)
        view.backgroundColor = UIColor(hexCode: "ff00ff")
        
        // §23.3 Coloor with Alpha Component
        view.backgroundColor = UIColor.red.withAlphaComponent(0.1)
        
        // §23.4 Undocumented Methods
        // このようにキャストするとプライベートメソッドにアクセスできる。
        // (staticにアクセスする方法も紹介されていたが、うまくできなかった。)
        let whitePrivate = unsafeBitCast(UIColor.white, to: UIColorPrivate.self)
        let redPrivate = unsafeBitCast(UIColor.red, to: UIColorPrivate.self)
        let lightTextColorPrivate = unsafeBitCast(UIColor.lightText, to: UIColorPrivate.self)
        print(whitePrivate.styleString(), redPrivate.styleString(), lightTextColorPrivate.styleString())
        
        // §23.6 Lighter and Darker Shade of a given UIColor
        view.backgroundColor = .red
        lighterView.backgroundColor = .red.lighter()
        darkerView.backgroundColor = .red.darker()
        
        // §23.7 Make user defined attributes apply the CGColor dataType
        // Interface BuilderはCGColorが使えない
        
    }


}

// §23.2
extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xff) / 255
        let g = CGFloat((hex >> 08) & 0xff) / 255
        let b = CGFloat((hex >> 00) & 0xff) / 255
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(hexCode: String) {
        let hex = hexCode.trimmingCharacters(in: .alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

// §23.4
@objc protocol UIColorPrivate {
    func styleString() -> String
}

// §23.6
extension UIColor {
    func darker() -> UIColor {
        var r = CGFloat()
        var g = CGFloat()
        var b = CGFloat()
        var a = CGFloat()
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(
            red: max(r - 0.2, 0),
            green: max(g - 0.2, 0),
            blue: max(b - 0.2, 0),
            alpha: a
        )
    }
    
    func lighter() -> UIColor {
        var r = CGFloat()
        var g = CGFloat()
        var b = CGFloat()
        var a = CGFloat()
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return UIColor(
            red: min(r + 0.2, 1.0),
            green: min(g + 0.2, 1.0),
            blue: min(b + 0.2, 1.0),
            alpha: a
        )
    }
}

// §23.7
// InterfaceBuilderでlayer.borderUIColor というKeyPathで設定できるようになる。
extension CALayer {
    func borderUIColor() -> UIColor? {
        return borderColor != nil ? UIColor(cgColor: borderColor!) : nil
    }
    
    func setBorderUIColor(color: UIColor) {
        borderColor = color.cgColor
    }
}
