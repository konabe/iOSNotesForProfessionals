//
//  ViewController.swift
//  Chapter32_UIScrollViewWithStackViewChild
//
//  Created by 小鍋涼太 on 2021/09/05.
//

import UIKit

// Chapter32: UIScrollView with Stack View child

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var birthDateTextField: UITextField!
    @IBOutlet weak var aboutTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §32.1 A complex StackView inside Scrollview Example
        // IBにて実装
        
        // §32.2 Preventing ambiguous layout
        // 基礎的な内容でした
        
        // §32.3 Scrolling to content inside nested StackViews
        birthDateTextField.delegate = self
        aboutTextfield.delegate = self
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.scrollToShowView(view: textField)
    }
}

extension UIScrollView {
    func scrollToShowView(view: UIView) {
        var offset = view.frame.minY
        var superview = view.superview
        while superview != nil {
            offset += superview!.frame.minY
            superview = superview?.superview
        }
        offset -= 100
        self.contentOffset = CGPoint(x: 0, y: offset)
    }
}
