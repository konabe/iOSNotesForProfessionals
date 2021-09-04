//
//  ViewController.swift
//  Chapter25_UITextFieldDelegate
//
//  Created by 小鍋涼太 on 2021/09/04.
//

import UIKit

// Chapter25: UITextField Delegate

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // §25.1 Actions when a user has started/ended interacting with a textField
        textField.delegate = self
        emailTextField.delegate = self
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            textField.backgroundColor = .green.withAlphaComponent(0.1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.emailTextField {
            textField.backgroundColor = .blue.withAlphaComponent(0.1)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        // ここでtrueを返さないと、編集できない。
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // ここでtrueを返さないと、キーボードが消えない。
        return true
    }
    
    // §25.2 UITextField - Restrict textfield to certain characters
    // 入力文字を制限する方法（この場合は数字以外入らない）
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //let allowedCharacters = CharacterSet(charactersIn: "0123456789").inverted
        let allowedCharacters = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: allowedCharacters)
        let filtered = components.joined(separator: "")
        return string == filtered
    }
}
