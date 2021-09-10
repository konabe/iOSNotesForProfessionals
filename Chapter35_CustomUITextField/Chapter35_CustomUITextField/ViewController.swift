//
//  ViewController.swift
//  Chapter35_CustomUITextField
//
//  Created by 小鍋涼太 on 2021/09/10.
//

import UIKit

// Chapter35: Custom UITextField

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §35.1 Custom UITextField for Filtering Input Text
        // iPhoneだったらNumber typeのキーボード、iPadだったらNumberだけのやつは出さない
        
        // §35.2 Custom UITextField to Disallow All Actions like Copy, Paste, etc
        // コピーペーストなどができないようにする
    }


}

// §35.1
class NumberTextField: UITextField {
    var enableLongPressAction = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForTextFieldNotifications()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keyboardType = .numberPad
    }
    
    private func registerForTextFieldNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(NumberTextField.textDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func textDidChange() {
        text = filteredText()
    }
    
    private func filteredText() -> String {
        let inverseSet = CharacterSet(charactersIn: "01").inverted
        let components = text!.components(separatedBy: inverseSet)
        return components.joined(separator: "")
    }
    
    // §35.2
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return enableLongPressAction
    }
    
}
