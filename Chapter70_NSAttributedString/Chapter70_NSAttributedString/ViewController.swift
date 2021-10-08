//
//  ViewController.swift
//  Chapter70_NSAttributedString
//
//  Created by 小鍋涼太 on 2021/10/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // §70.1 Creating a string that has custom kerning (letter spacing)
        // kern=文字の間隔
        let attributedString = NSMutableAttributedString("Apply kerning")
        attributedString.addAttribute(.kern, value: 5, range: NSRange(location: 6, length: 7))
        let label1 = UILabel(frame: CGRect(x: 20, y: 40, width: view.frame.width, height: 50))
        label1.attributedText = attributedString
        view.addSubview(label1)
        
        // §70.2 Change the color of a word or string
        let color = UIColor.red
        let textToFind = "redword"
        let sentence = "this includes redword for test."
        let attributedString2 = NSMutableAttributedString(string: sentence)
        let range = (sentence as NSString).range(of: textToFind)
        if range.length > 0 {
            attributedString2.addAttribute(.foregroundColor, value: color, range: range)
        }
        let label2 = UILabel(frame: CGRect(x: 20, y: 140, width: view.frame.width, height: 50))
        label2.attributedText = attributedString2
        view.addSubview(label2)
        
        // §70.3 Removing all attributes
        attributedString2.setAttributes([:], range: NSRange(0..<attributedString2.length))
//        label2.attributedText = attributedString2
        
        // §70.4 Appending Attributed Strings and bold text in Swift
        let someValue = "Something the user entered"
        let text = NSMutableAttributedString(string: "The value is: ")
        text.append(NSAttributedString(string: someValue, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)]))
        let label3 = UILabel(frame: CGRect(x: 20, y: 240, width: view.frame.width, height: 50))
        label3.attributedText = text
        view.addSubview(label3)
        
        // §70.5 Create a string with strikethrough text
        let attributedString4 = NSMutableAttributedString(string: "Your String here")
        attributedString4.addAttribute(.strikethroughStyle, value: 2, range: NSRange(0..<attributedString4.length))
        let label4 = UILabel(frame: CGRect(x: 20, y: 340, width: view.frame.width, height: 50))
        label4.attributedText = attributedString4
        view.addSubview(label4)
        
    }


}

